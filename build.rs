use itertools::Itertools;
use proc_macro2::TokenStream;
use quote::quote;
use std::{error::Error, fs::File, io::Write, path::Path};

#[derive(Debug, PartialEq, Eq)]
enum VecType {
    U,
    I,
    F,
}

fn span() -> proc_macro2::Span {
    proc_macro2::Span::call_site()
}

impl VecType {
    fn type_ident(&self) -> syn::Ident {
        match self {
            VecType::U => syn::Ident::new("u32", span()),
            VecType::I => syn::Ident::new("i32", span()),
            VecType::F => syn::Ident::new("f32", span()),
        }
    }

    fn all() -> Vec<VecType> {
        vec![VecType::U, VecType::I, VecType::F]
    }
}

struct GenericVec<'a> {
    vec_type: &'a VecType,
    fields: &'a Vec<&'a str>,
}

fn gen_vec(vec: GenericVec) -> TokenStream {
    let name = quote::format_ident!(
        "{}Vec{}",
        match vec.vec_type {
            VecType::U => "U",
            VecType::I => "I",
            VecType::F => "",
        },
        vec.fields.len()
    );
    let fields = vec
        .fields
        .iter()
        .map(|f| quote::format_ident!("{f}"))
        .collect_vec();

    let type_ident = vec.vec_type.type_ident();
    let type_idents = vec![type_ident.clone(); fields.len()];
    let hash = (vec.vec_type != &VecType::F).then_some(quote! {Hash,});
    let neg = (vec.vec_type != &VecType::U).then_some(quote! {
        impl std::ops::Neg for #name {
            type Output = Self;
            fn neg(self) -> Self {
                Self {
                    #(#fields: -self.#fields,)*
                }
            }
        }
    });
    let vec_ident = quote::format_ident!("as_vec{}", fields.len());
    let ivec_ident = quote::format_ident!("as_ivec{}", fields.len());
    let uvec_ident = quote::format_ident!("as_uvec{}", fields.len());

    let vec_name = quote::format_ident!("Vec{}", fields.len());
    let ivec_name = quote::format_ident!("IVec{}", fields.len());
    let uvec_name = quote::format_ident!("UVec{}", fields.len());

    let mut conversions = vec![
        quote! {
            pub fn #vec_ident(&self) -> #vec_name {
                #vec_name {
                    #(#fields: self.#fields as f32),*
                }
            }
        },
        quote! {
            pub fn #ivec_ident(&self) -> #ivec_name {
                #ivec_name {
                    #(#fields: self.#fields as i32),*
                }
            }
        },
        quote! {
            pub fn #uvec_ident(&self) -> #uvec_name {
                #uvec_name {
                    #(#fields: self.#fields as u32),*
                }
            }
        },
    ];
    conversions.remove(match vec.vec_type {
        VecType::F => 0,
        VecType::I => 1,
        VecType::U => 2,
    });

    let get_fields = vec.fields.iter().enumerate().map(|(id, f)| {
        let id: i32 = (id as i32) + 1;
        let field_ident = quote::format_ident!("{f}");
        let set_err = format!(
            "could not get `{}`s field `{f}` of type `{}`",
            name,
            vec.vec_type.type_ident()
        );
        quote! {
            #field_ident: mlua::ErrorContext::with_context(table.raw_get(#id), |_| {
                #set_err
            })?,
        }
    });
    let set_fields = vec.fields.iter().enumerate().map(|(id, f)| {
        let id: i32 = (id as i32) + 1;
        let field_ident = quote::format_ident!("{f}");
        let set_err = format!(
            "could not set `{}`s field `{f}` of type `{}`",
            name,
            vec.vec_type.type_ident()
        );
        quote! {
            mlua::ErrorContext::with_context(table.raw_set(#id, self.#field_ident), |_| {
                #set_err
            })?;
        }
    });

    let metatable_name = format!(
        "{}vec{}_metatable",
        match vec.vec_type {
            VecType::U => "i",
            VecType::I => "i",
            VecType::F => "",
        },
        vec.fields.len()
    );
    let float_fns = (vec.vec_type == &VecType::F).then_some(quote! {
        pub fn floor(self) -> Self {
            Self {
                #(#fields: self.#fields.floor()),*
            }
        }
        pub fn fract(self) -> Self {
            self - self.trunc()
        }
        pub fn fract_gl(self) -> Self {
            self - self.floor()
        }
        pub fn trunc(self) -> Self {
            Self {
                #(#fields: self.#fields.trunc()),*
            }
        }
        pub fn ceil(self) -> Self {
            Self {
                #(#fields: self.#fields.ceil()),*
            }
        }
        pub fn round(self) -> Self {
            Self {
                #(#fields: self.#fields.round()),*
            }
        }
        pub fn lerp(self, rhs: Self, s: f32) -> Self {
            self * (1.0 - s) + rhs * s
        }
        pub fn normalize(self) -> Self {
            self / self.length()
        }
        pub fn max(self, rhs: Self) -> Self {
            Self {
                #(#fields: self.#fields.max(rhs.#fields)),*
            }
        }
        pub fn min(self, rhs: Self) -> Self {
            Self {
                #(#fields: self.#fields.min(rhs.#fields)),*
            }
        }
        pub fn clamp(self, min: Self, max: Self) -> Self {
            Self {
                #(#fields: self.#fields.clamp(min.#fields, max.#fields)),*
            }
        }
        pub fn move_towards(self, rhs: Self, d: f32) -> Self {
            let a = rhs - self;
            let len = a.length();
            if len <= d || len <= 1e-4 {
                return rhs;
            }
            self + a / len * d
        }
        pub fn midpoint(self, rhs: Self) -> Self {
            (self + rhs) * 0.5
        }
        pub fn dot(self, other: Self) -> f32 {
            #(self.#fields * other.#fields)+*
        }
    });
    let abs_fn = (vec.vec_type != &VecType::U).then_some(quote! {
        pub fn abs(self) -> Self {
            Self {
                #(#fields: self.#fields.abs()),*
            }
        }
    });

    quote! {
        #[derive(Default, Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize, #hash)]
        pub struct #name {
            #(
                pub #fields: #type_ident,
            )*
        }

        impl mlua::FromLua for #name {
            fn from_lua(value: mlua::Value, _lua: &mlua::Lua) -> mlua::Result<Self> {
                let table = value.as_table().ok_or_else(|| {
                    lua_error::lua_error!(
                        "`{}` should be a table, got `{}` instead",
                        stringify!(#name),
                        value.type_name()
                    )
                })?;
                Ok(#name {
                    #(#get_fields)*
                })
            }
        }

        impl mlua::IntoLua for #name {
            fn into_lua(self, lua: &mlua::Lua) -> mlua::Result<mlua::Value> {
                let table = lua.create_table()?;
                let inner_table = lua
                    .globals()
                    .get::<Option<mlua::Table>>("__inner")?
                    .ok_or_else(|| lua_error::lua_error!("could not get __inner"))?;
                let meth_table = mlua::ErrorContext::with_context(
                    inner_table.get::<mlua::Table>("meth"), |_| "could not get __inner.meth table")?;
                let metatable = meth_table
                    .get::<Option<mlua::Table>>(#metatable_name)?
                    .ok_or_else(|| lua_error::lua_error!("could not get metatable {}", #metatable_name))?;
                table.set_metatable(Some(metatable));
                #(#set_fields)*
                Ok(mlua::Value::Table(table))
            }
        }

        impl #name {
            #(#conversions)*
            pub const fn splat(value: #type_ident) -> Self {
                Self {#(#fields: value,)*}
            }
            pub const fn new(#(#fields: #type_ident,)*) -> Self {
                Self {
                    #(#fields,)*
                }
            }
            pub fn length(self) -> f32 {
                (#((self.#fields as f32) * (self.#fields as f32))+*).sqrt()
            }
            pub fn length_squared(self) -> f32 {
                #((self.#fields as f32) * (self.#fields as f32))+*
            }
            pub fn unpack(self) -> (#(#type_idents),*) {
                (#(
                    (self.#fields)
                ),*)
            }
            #float_fns
            #abs_fn
        }

        impl std::ops::Add<#name> for #name {
            type Output = Self;

            fn add(self, other: Self) -> Self {
                Self {
                    #(#fields: self.#fields + other.#fields,)*
                }
            }
        }

        impl std::ops::AddAssign<#name> for #name {
            fn add_assign(&mut self, other: Self) {
                #(self.#fields += other.#fields;)*
            }
        }

        impl std::ops::Add<#type_ident> for #name {
            type Output = Self;

            fn add(self, other: #type_ident) -> Self {
                Self {
                    #(#fields: self.#fields + other,)*
                }
            }
        }

        impl std::ops::AddAssign<#type_ident> for #name {
            fn add_assign(&mut self, other: #type_ident) {
                #(self.#fields += other;)*
            }
        }

        impl std::ops::Sub<#name> for #name {
            type Output = Self;

            fn sub(self, other: Self) -> Self {
                Self {
                    #(#fields: self.#fields - other.#fields,)*
                }
            }
        }

        impl std::ops::SubAssign<#name> for #name {
            fn sub_assign(&mut self, other: Self) {
                #(self.#fields -= other.#fields;)*
            }
        }

        impl std::ops::Sub<#type_ident> for #name {
            type Output = Self;

            fn sub(self, other: #type_ident) -> Self {
                Self {
                    #(#fields: self.#fields - other,)*
                }
            }
        }

        impl std::ops::SubAssign<#type_ident> for #name {
            fn sub_assign(&mut self, other: #type_ident) {
                #(self.#fields -= other;)*
            }
        }

        impl std::ops::Mul<#name> for #name {
            type Output = Self;

            fn mul(self, other: Self) -> Self {
                Self {
                    #(#fields: self.#fields * other.#fields,)*
                }
            }
        }

        impl std::ops::MulAssign<#name> for #name {
            fn mul_assign(&mut self, other: Self) {
                #(self.#fields *= other.#fields;)*
            }
        }

        impl std::ops::Mul<#type_ident> for #name {
            type Output = Self;

            fn mul(self, other: #type_ident) -> Self {
                Self {
                    #(#fields: self.#fields * other,)*
                }
            }
        }

        impl std::ops::MulAssign<#type_ident> for #name {
            fn mul_assign(&mut self, other: #type_ident) {
                #(self.#fields *= other;)*
            }
        }

        impl std::ops::Div<#name> for #name {
            type Output = Self;

            fn div(self, other: Self) -> Self {
                Self {
                    #(#fields: self.#fields / other.#fields,)*
                }
            }
        }

        impl std::ops::DivAssign<#name> for #name {
            fn div_assign(&mut self, other: Self) {
                #(self.#fields /= other.#fields;)*
            }
        }

        impl std::ops::Div<#type_ident> for #name {
            type Output = Self;

            fn div(self, other: #type_ident) -> Self {
                Self {
                    #(#fields: self.#fields / other,)*
                }
            }
        }

        impl std::ops::DivAssign<#type_ident> for #name {
            fn div_assign(&mut self, other: #type_ident) {
                #(self.#fields /= other;)*
            }
        }

        #neg
    }
}

fn copy_dir(source: impl AsRef<Path>, dest: impl AsRef<Path>) {
    let (source, dest) = (source.as_ref(), dest.as_ref());
    if dest.exists() {
        return;
    }
    if !source.exists() {
        panic!("could not copy from {source:?}: dir does not exist")
    }

    dircpy::copy_dir(source, dest).unwrap();
}

fn main() -> Result<(), Box<dyn Error>> {
    copy_dir("../lopa-test/src/lua/lopa-test/", "src/lua/lopa-test/");
    std::fs::copy(
        "../lopa-test/src/lua/lopa-test.lua",
        "src/lua/lopa-test.lua",
    )
    .unwrap();

    let fields = [
        vec!["x", "y"],
        vec!["x", "y", "z"],
        vec!["x", "y", "z", "w"],
    ];

    let mut code_pieces = vec![];
    for (fields, vec_type) in fields.iter().cartesian_product(VecType::all().iter()) {
        let generic_vec = GenericVec { vec_type, fields };
        let code = gen_vec(generic_vec);
        code_pieces.push((code, fields.len()));
    }

    let sizes = [2, 3, 4];
    for vec_size in sizes {
        let code = code_pieces
            .iter()
            .filter(|(_, size)| *size == vec_size)
            .map(|(code, _)| code)
            .collect_vec();
        let path = format!("src/vec{vec_size}.rs");
        // if Path::new(&path).exists() {
        //     return Ok(());
        // }
        let mut file = File::create(path)?;
        file.write_all(quote! {#(#code)*}.to_string().as_bytes())?;
    }

    Ok(())
}
