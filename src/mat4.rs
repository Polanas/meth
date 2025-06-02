use std::ops::{Add, AddAssign, Div, DivAssign, Mul, MulAssign, Sub, SubAssign};

use crate::vec4::Vec4;

#[derive(Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize, Default)]
pub struct Mat4 {
    pub x_axis: Vec4,
    pub y_axis: Vec4,
    pub z_axis: Vec4,
    pub w_axis: Vec4,
}

impl Mat4 {
    pub const fn from_axis(x_axis: Vec4, y_axis: Vec4, z_axis: Vec4, w_axis: Vec4) -> Self {
        Self {
            x_axis,
            y_axis,
            z_axis,
            w_axis,
        }
    }
    pub const fn splat(value: f32) -> Self {
        Self::from_axis(
            Vec4::splat(value),
            Vec4::splat(value),
            Vec4::splat(value),
            Vec4::splat(value),
        )
    }
}

impl Add for Mat4 {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs.x_axis,
            y_axis: self.y_axis + rhs.y_axis,
            z_axis: self.z_axis + rhs.z_axis,
            w_axis: self.w_axis + rhs.w_axis,
        }
    }
}

impl AddAssign<Mat4> for Mat4 {
    fn add_assign(&mut self, rhs: Self) {
        self.x_axis += rhs.x_axis;
        self.y_axis += rhs.y_axis;
        self.z_axis += rhs.z_axis;
        self.w_axis += rhs.w_axis;
    }
}

impl Add<f32> for Mat4 {
    type Output = Self;

    fn add(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs,
            y_axis: self.y_axis + rhs,
            z_axis: self.z_axis + rhs,
            w_axis: self.w_axis + rhs,
        }
    }
}

impl AddAssign<f32> for Mat4 {
    fn add_assign(&mut self, rhs: f32) {
        self.x_axis += rhs;
        self.y_axis += rhs;
        self.z_axis += rhs;
        self.w_axis += rhs;
    }
}

impl Sub for Mat4 {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs.x_axis,
            y_axis: self.y_axis - rhs.y_axis,
            z_axis: self.z_axis - rhs.z_axis,
            w_axis: self.w_axis - rhs.w_axis,
        }
    }
}

impl SubAssign for Mat4 {
    fn sub_assign(&mut self, rhs: Self) {
        self.x_axis -= rhs.x_axis;
        self.y_axis -= rhs.y_axis;
        self.z_axis -= rhs.z_axis;
        self.w_axis -= rhs.w_axis;
    }
}

impl Sub<f32> for Mat4 {
    type Output = Self;

    fn sub(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs,
            y_axis: self.y_axis - rhs,
            z_axis: self.z_axis - rhs,
            w_axis: self.w_axis - rhs,
        }
    }
}

impl SubAssign<f32> for Mat4 {
    fn sub_assign(&mut self, rhs: f32) {
        self.x_axis -= rhs;
        self.y_axis -= rhs;
        self.z_axis -= rhs;
        self.w_axis -= rhs;
    }
}

impl Mul<f32> for Mat4 {
    type Output = Self;

    fn mul(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis * rhs,
            y_axis: self.y_axis * rhs,
            z_axis: self.z_axis * rhs,
            w_axis: self.w_axis * rhs,
        }
    }
}

impl MulAssign<f32> for Mat4 {
    fn mul_assign(&mut self, rhs: f32) {
        self.x_axis *= rhs;
        self.y_axis *= rhs;
        self.z_axis *= rhs;
        self.w_axis *= rhs;
    }
}

impl Mul for Mat4 {
    type Output = Mat4;

    fn mul(self, rhs: Self) -> Self::Output {
        let (a11, a21, a31, a41) = self.x_axis.unpack();
        let (a12, a22, a32, a42) = self.y_axis.unpack();
        let (a13, a23, a33, a43) = self.z_axis.unpack();
        let (a14, a24, a34, a44) = self.w_axis.unpack();

        let (b11, b21, b31, b41) = rhs.x_axis.unpack();
        let (b12, b22, b32, b42) = rhs.y_axis.unpack();
        let (b13, b23, b33, b43) = rhs.z_axis.unpack();
        let (b14, b24, b34, b44) = rhs.w_axis.unpack();
        Self {
            x_axis: Vec4 {
                x: a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41,
                y: a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41,
                z: a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41,
                w: a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41,
            },
            y_axis: Vec4 {
                x: a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42,
                y: a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42,
                z: a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42,
                w: a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42,
            },
            z_axis: Vec4 {
                x: a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43,
                y: a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43,
                z: a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43,
                w: a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43,
            },
            w_axis: Vec4 {
                x: a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44,
                y: a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44,
                z: a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44,
                w: a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44,
            },
        }
    }
}

impl MulAssign for Mat4 {
    fn mul_assign(&mut self, rhs: Self) {
        let (a11, a21, a31, a41) = self.x_axis.unpack();
        let (a12, a22, a32, a42) = self.y_axis.unpack();
        let (a13, a23, a33, a43) = self.z_axis.unpack();
        let (a14, a24, a34, a44) = self.w_axis.unpack();

        let (b11, b21, b31, b41) = rhs.x_axis.unpack();
        let (b12, b22, b32, b42) = rhs.y_axis.unpack();
        let (b13, b23, b33, b43) = rhs.z_axis.unpack();
        let (b14, b24, b34, b44) = rhs.w_axis.unpack();

        self.x_axis.x = a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41;
        self.x_axis.y = a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41;
        self.x_axis.z = a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41;
        self.x_axis.w = a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41;

        self.y_axis.x = a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42;
        self.y_axis.y = a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42;
        self.y_axis.z = a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42;
        self.y_axis.w = a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42;

        self.z_axis.x = a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43;
        self.z_axis.y = a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43;
        self.z_axis.z = a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43;
        self.z_axis.w = a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43;

        self.w_axis.x = a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44;
        self.w_axis.y = a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44;
        self.w_axis.z = a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44;
        self.w_axis.w = a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44;
    }
}

impl Div<f32> for Mat4 {
    type Output = Self;

    fn div(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis / rhs,
            y_axis: self.y_axis / rhs,
            z_axis: self.z_axis / rhs,
            w_axis: self.w_axis / rhs,
        }
    }
}

impl DivAssign<f32> for Mat4 {
    fn div_assign(&mut self, rhs: f32) {
        self.x_axis /= rhs;
        self.y_axis /= rhs;
        self.z_axis /= rhs;
        self.w_axis /= rhs;
    }
}

impl Mul<Vec4> for Mat4 {
    type Output = Vec4;

    fn mul(self, rhs: Vec4) -> Self::Output {
        let (a11, a21, a31, a41) = self.x_axis.unpack();
        let (a12, a22, a32, a42) = self.y_axis.unpack();
        let (a13, a23, a33, a43) = self.z_axis.unpack();
        let (a14, a24, a34, a44) = self.w_axis.unpack();

        let (b11, b21, b31, b41) = rhs.unpack();

        Vec4 {
            x: a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41,
            y: a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41,
            z: a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41,
            w: a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41,
        }
    }
}

impl mlua::FromLua for Mat4 {
    fn from_lua(value: mlua::Value, _lua: &mlua::Lua) -> mlua::Result<Self> {
        let table = value.as_table().ok_or_else(|| {
            lua_error::lua_error!(
                "`{}` should be a table, got `{}` instead",
                stringify!(Mat4),
                value.type_name()
            )
        })?;
        Ok(Mat4 {
            x_axis: Vec4 {
                x: mlua::ErrorContext::with_context(table.raw_get(1u32), |_| {
                    "could not get `Mat4`s field `x_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(2u32), |_| {
                    "could not get `Mat4`s field `x_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(3u32), |_| {
                    "could not get `Mat4`s field `x_axis.z` of type `f32`"
                })?,
                w: mlua::ErrorContext::with_context(table.raw_get(4u32), |_| {
                    "could not get `Mat4`s field `x_axis.w` of type `f32`"
                })?,
            },
            y_axis: Vec4 {
                x: mlua::ErrorContext::with_context(table.raw_get(5u32), |_| {
                    "could not get `Mat4`s field `y_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(6u32), |_| {
                    "could not get `Mat4`s field `y_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(7u32), |_| {
                    "could not get `Mat4`s field `y_axis.z` of type `f32`"
                })?,
                w: mlua::ErrorContext::with_context(table.raw_get(8u32), |_| {
                    "could not get `Mat4`s field `y_axis.w` of type `f32`"
                })?,
            },
            z_axis: Vec4 {
                x: mlua::ErrorContext::with_context(table.raw_get(9u32), |_| {
                    "could not get `Mat4`s field `z_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(10u32), |_| {
                    "could not get `Mat4`s field `z_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(11u32), |_| {
                    "could not get `Mat4`s field `z_axis.z` of type `f32`"
                })?,
                w: mlua::ErrorContext::with_context(table.raw_get(12u32), |_| {
                    "could not get `Mat4`s field `z_axis.w` of type `f32`"
                })?,
            },
            w_axis: Vec4 {
                x: mlua::ErrorContext::with_context(table.raw_get(13u32), |_| {
                    "could not get `Mat4`s field `w_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(14u32), |_| {
                    "could not get `Mat4`s field `w_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(15u32), |_| {
                    "could not get `Mat4`s field `w_axis.z` of type `f32`"
                })?,
                w: mlua::ErrorContext::with_context(table.raw_get(16u32), |_| {
                    "could not get `Mat4`s field `w_axis.w` of type `f32`"
                })?,
            },
        })
    }
}

impl mlua::IntoLua for Mat4 {
    fn into_lua(self, lua: &mlua::Lua) -> mlua::Result<mlua::Value> {
        let table = lua.create_table()?;
        let inner_table = lua
            .globals()
            .get::<Option<mlua::Table>>("__inner")?
            .ok_or_else(|| lua_error::lua_error!("could not get __inner"))?;
        let metatable = inner_table
            .get::<Option<mlua::Table>>("mat3_metatable")?
            .ok_or_else(|| lua_error::lua_error!("could not get metatable {}", "mat3_metatable"))?;
        table.set_metatable(Some(metatable));
        mlua::ErrorContext::with_context(table.raw_set(1i32, self.x_axis.x), |_| {
            "could not set `Mat4`s field `x_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(2i32, self.x_axis.y), |_| {
            "could not set `Mat4`s field `x_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(3i32, self.x_axis.z), |_| {
            "could not set `Mat4`s field `x_axis.z` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(4i32, self.x_axis.w), |_| {
            "could not set `Mat4`s field `x_axis.w` of type `f32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(5i32, self.y_axis.x), |_| {
            "could not set `Mat4`s field `y_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(6i32, self.y_axis.y), |_| {
            "could not set `Mat4`s field `y_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(7i32, self.y_axis.z), |_| {
            "could not set `Mat4`s field `y_axis.z` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(8i32, self.y_axis.w), |_| {
            "could not set `Mat4`s field `y_axis.w` of type `f32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(9i32, self.z_axis.x), |_| {
            "could not set `Mat4`s field `z_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(10i32, self.z_axis.y), |_| {
            "could not set `Mat4`s field `z_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(11i32, self.z_axis.z), |_| {
            "could not set `Mat4`s field `z_axis.z` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(12i32, self.z_axis.w), |_| {
            "could not set `Mat4`s field `z_axis.w` of type `f32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(13i32, self.w_axis.x), |_| {
            "could not set `Mat4`s field `w_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(14i32, self.w_axis.y), |_| {
            "could not set `Mat4`s field `w_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(15i32, self.w_axis.z), |_| {
            "could not set `Mat4`s field `w_axis.z` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(16i32, self.w_axis.w), |_| {
            "could not set `Mat4`s field `w_axis.w` of type `f32`"
        })?;
        Ok(mlua::Value::Table(table))
    }
}

#[cfg(test)]
mod test {
    use crate::vec4::Vec4;

    use super::Mat4;

    #[test]
    fn matrix_x_vector() {
        let m1 = Mat4::from_axis(
            Vec4::new(1., 2., 3., 4.),
            Vec4::new(5., 6., 7., 8.),
            Vec4::new(1., 2., 3., 4.),
            Vec4::new(5., 6., 7., 8.),
        );
        let v1 = Vec4::new(1., 2., 3., 4.);
        assert_eq!(m1 * v1, Vec4::new(34., 44., 54., 64.));
    }

    #[test]
    fn matrix_x_matrix() {
        let m1 = Mat4::from_axis(
            Vec4::new(1., 2., 3., 4.),
            Vec4::new(5., 6., 7., 8.),
            Vec4::new(1., 2., 3., 4.),
            Vec4::new(5., 6., 7., 8.),
        );
        let m2 = Mat4::from_axis(
            Vec4::new(8., 7., 6., 5.),
            Vec4::new(4., 3., 2., 1.),
            Vec4::new(8., 7., 6., 5.),
            Vec4::new(4., 3., 2., 1.),
        );

        assert_eq!(
            m1 * m2,
            Mat4::from_axis(
                Vec4::new(74., 100., 126., 152.),
                Vec4::new(26., 36., 46., 56.),
                Vec4::new(74., 100., 126., 152.),
                Vec4::new(26., 36., 46., 56.),
            )
        )
    }
}
