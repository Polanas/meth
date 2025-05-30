use crate::vec3::Vec3;

#[derive(Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize)]
pub struct Mat3 {
    pub x_axis: Vec3,
    pub y_axis: Vec3,
    pub z_axis: Vec3,
}

impl mlua::FromLua for Mat3 {
    fn from_lua(value: mlua::Value, _lua: &mlua::Lua) -> mlua::Result<Self> {
        let table = value.as_table().ok_or_else(|| {
            lua_error::lua_error!(
                "`{}` should be a table, got `{}` instead",
                stringify!(Mat3),
                value.type_name()
            )
        })?;
        Ok(Mat3 {
            x_axis: Vec3 {
                x: mlua::ErrorContext::with_context(table.raw_get(1u32), |_| {
                    "could not get `Mat3`s field `x_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(2u32), |_| {
                    "could not get `Mat3`s field `x_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(3u32), |_| {
                    "could not get `Mat3`s field `x_axis.z` of type `f32`"
                })?,
            },
            y_axis: Vec3 {
                x: mlua::ErrorContext::with_context(table.raw_get(4u32), |_| {
                    "could not get `Mat3`s field `y_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(5u32), |_| {
                    "could not get `Mat3`s field `y_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(6u32), |_| {
                    "could not get `Mat3`s field `y_axis.z` of type `f32`"
                })?,
            },
            z_axis: Vec3 {
                x: mlua::ErrorContext::with_context(table.raw_get(7u32), |_| {
                    "could not get `Mat3`s field `z_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(8u32), |_| {
                    "could not get `Mat3`s field `z_axis.y` of type `f32`"
                })?,
                z: mlua::ErrorContext::with_context(table.raw_get(9u32), |_| {
                    "could not get `Mat3`s field `z_axis.z` of type `f32`"
                })?,
            },
        })
    }
}

impl mlua::IntoLua for Mat3 {
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
            "could not set `Mat3`s field `x_axis.x` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(2i32, self.x_axis.y), |_| {
            "could not set `Mat3`s field `x_axis.y` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(3i32, self.x_axis.y), |_| {
            "could not set `Mat3`s field `x_axis.z` of type `u32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(4i32, self.y_axis.x), |_| {
            "could not set `Mat3`s field `y_axis.x` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(5i32, self.y_axis.y), |_| {
            "could not set `Mat3`s field `y_axis.y` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(6i32, self.y_axis.y), |_| {
            "could not set `Mat3`s field `y_axis.z` of type `u32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(7i32, self.z_axis.x), |_| {
            "could not set `Mat3`s field `z_axis.x` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(8i32, self.z_axis.y), |_| {
            "could not set `Mat3`s field `z_axis.y` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(9i32, self.z_axis.y), |_| {
            "could not set `Mat3`s field `z_axis.z` of type `u32`"
        })?;
        Ok(mlua::Value::Table(table))
    }
}
