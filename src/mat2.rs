use std::ops::{Add, AddAssign, Div, DivAssign, Mul, MulAssign, Sub, SubAssign};

use crate::vec2::Vec2;

#[derive(Default, Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize)]
pub struct Mat2 {
    pub x_axis: Vec2,
    pub y_axis: Vec2,
}

impl Mat2 {
    pub const ZERO: Self = Self::splat(0.0);
    pub const IDENTITY: Self = Self::new(1.0, 0.0, 0.0, 1.0);
    pub const fn new(x0: f32, y0: f32, x1: f32, y1: f32) -> Self {
        Self {
            x_axis: Vec2::new(x0, y0),
            y_axis: Vec2::new(x1, y1),
        }
    }
    pub const fn from_axis(x_axis: Vec2, y_axis: Vec2) -> Self {
        Self { x_axis, y_axis }
    }
    pub const fn splat(value: f32) -> Self {
        Self::from_axis(Vec2::splat(value), Vec2::splat(value))
    }
    pub fn from_angle(angle: f32) -> Self {
        let (sin, cos) = f32::sin_cos(angle);
        Self::new(cos, -sin, sin, cos)
    }
}

impl Add for Mat2 {
    type Output = Mat2;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs.x_axis,
            y_axis: self.y_axis + rhs.y_axis,
        }
    }
}

impl AddAssign<Mat2> for Mat2 {
    fn add_assign(&mut self, rhs: Mat2) {
        self.x_axis += rhs.x_axis;
        self.y_axis += rhs.y_axis;
    }
}

impl Add<f32> for Mat2 {
    type Output = Mat2;

    fn add(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs,
            y_axis: self.y_axis + rhs,
        }
    }
}

impl AddAssign<f32> for Mat2 {
    fn add_assign(&mut self, rhs: f32) {
        self.x_axis += rhs;
        self.y_axis += rhs;
    }
}

impl Sub for Mat2 {
    type Output = Mat2;

    fn sub(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs.x_axis,
            y_axis: self.y_axis - rhs.y_axis,
        }
    }
}

impl SubAssign<Mat2> for Mat2 {
    fn sub_assign(&mut self, rhs: Mat2) {
        self.x_axis -= rhs.x_axis;
        self.y_axis -= rhs.y_axis;
    }
}

impl Sub<f32> for Mat2 {
    type Output = Mat2;

    fn sub(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs,
            y_axis: self.y_axis - rhs,
        }
    }
}

impl SubAssign<f32> for Mat2 {
    fn sub_assign(&mut self, rhs: f32) {
        self.x_axis -= rhs;
        self.y_axis -= rhs;
    }
}

impl Mul<f32> for Mat2 {
    type Output = Mat2;

    fn mul(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis * rhs,
            y_axis: self.y_axis * rhs,
        }
    }
}

impl MulAssign<f32> for Mat2 {
    fn mul_assign(&mut self, rhs: f32) {
        self.x_axis *= rhs;
        self.y_axis *= rhs;
    }
}

impl Mul for Mat2 {
    type Output = Mat2;

    fn mul(self, rhs: Self) -> Self::Output {
        let (a, c, b, d) = (self.x_axis.x, self.x_axis.y, self.y_axis.x, self.y_axis.y);
        let (e, g, f, h) = (rhs.x_axis.x, rhs.x_axis.y, rhs.y_axis.x, rhs.y_axis.y);
        Self {
            x_axis: Vec2 {
                x: a * e + b * g,
                y: c * e + d * g,
            },
            y_axis: Vec2 {
                x: a * f + b * h,
                y: c * f + d * h,
            },
        }
    }
}

impl MulAssign for Mat2 {
    fn mul_assign(&mut self, rhs: Self) {
        let (a, c, b, d) = (self.x_axis.x, self.x_axis.y, self.y_axis.x, self.y_axis.y);
        let (e, g, f, h) = (rhs.x_axis.x, rhs.x_axis.y, rhs.y_axis.x, rhs.y_axis.y);
        self.x_axis.x = a * e + b * g;
        self.x_axis.y = c * e + d * g;
        self.y_axis.x = a * f + b * h;
        self.y_axis.y = c * f + d * h;
    }
}

impl Mul<Vec2> for Mat2 {
    type Output = Vec2;

    fn mul(self, rhs: Vec2) -> Self::Output {
        let (x, y) = (rhs.x, rhs.y);
        let (a, b, c, d) = (self.x_axis.x, self.x_axis.y, self.y_axis.x, self.y_axis.y);
        Vec2 {
            x: a * x + c * y,
            y: b * x + d * y,
        }
    }
}

impl Div<f32> for Mat2 {
    type Output = Mat2;

    fn div(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis / rhs,
            y_axis: self.y_axis / rhs,
        }
    }
}

impl DivAssign<f32> for Mat2 {
    fn div_assign(&mut self, rhs: f32) {
        self.x_axis /= rhs;
        self.y_axis /= rhs;
    }
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
            .ok_or_else(|| lua_error::lua_error!("could not get metatable {}", "mat2_metatable"))?;
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
