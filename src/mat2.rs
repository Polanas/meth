use crate::vec2::Vec2;

#[derive(Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize)]
pub struct Mat2 {
    pub x_axis: Vec2,
    pub y_axis: Vec2,
}

impl mlua::FromLua for Mat2 {
    fn from_lua(value: mlua::Value, _lua: &mlua::Lua) -> mlua::Result<Self> {
        let table = value.as_table().ok_or_else(|| {
            lua_error::lua_error!(
                "`{}` should be a table, got `{}` instead",
                stringify!(Mat2),
                value.type_name()
            )
        })?;
        Ok(Mat2 {
            x_axis: Vec2 {
                x: mlua::ErrorContext::with_context(table.raw_get(1u32), |_| {
                    "could not get `Mat2`s field `x_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(2u32), |_| {
                    "could not get `Mat2`s field `x_axis.y` of type `f32`"
                })?,
            },
            y_axis: Vec2 {
                x: mlua::ErrorContext::with_context(table.raw_get(3u32), |_| {
                    "could not get `Mat2`s field `y_axis.x` of type `f32`"
                })?,
                y: mlua::ErrorContext::with_context(table.raw_get(4u32), |_| {
                    "could not get `Mat2`s field `y_axis.y` of type `f32`"
                })?,
            },
        })
    }
}

impl mlua::IntoLua for Mat2 {
    fn into_lua(self, lua: &mlua::Lua) -> mlua::Result<mlua::Value> {
        let table = lua.create_table()?;
        let inner_table = lua
            .globals()
            .get::<Option<mlua::Table>>("__inner")?
            .ok_or_else(|| lua_error::lua_error!("could not get __inner"))?;
        let metatable = inner_table
            .get::<Option<mlua::Table>>("mat2_metatable")?
            .ok_or_else(|| {
                lua_error::lua_error!("could not get metatable {}", "mat2_metatable")
            })?;
        table.set_metatable(Some(metatable));
        mlua::ErrorContext::with_context(table.raw_set(1i32, self.x_axis.x), |_| {
            "could not set `Mat2`s field `x_axis.x` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(2i32, self.x_axis.y), |_| {
            "could not set `Mat2`s field `x_axis.y` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(3i32, self.y_axis.x), |_| {
            "could not set `Mat2`s field `y_axis.x` of type `u32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(4i32, self.y_axis.y), |_| {
            "could not set `Mat2`s field `y_axis.y` of type `u32`"
        })?;
        Ok(mlua::Value::Table(table))
    }
}
