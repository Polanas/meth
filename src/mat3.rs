use std::ops::{Add, AddAssign, Div, DivAssign, Mul, MulAssign, Sub, SubAssign};

use crate::{vec2::Vec2, vec3::Vec3};

#[derive(Debug, PartialEq, Clone, Copy, serde::Serialize, serde::Deserialize, Default)]
pub struct Mat3 {
    pub x_axis: Vec3,
    pub y_axis: Vec3,
    pub z_axis: Vec3,
}

impl Mat3 {
    pub const fn from_axis(x_axis: Vec3, y_axis: Vec3, z_axis: Vec3) -> Self {
        Self {
            x_axis,
            y_axis,
            z_axis,
        }
    }
    pub const fn splat(value: f32) -> Self {
        Self::from_axis(Vec3::splat(value), Vec3::splat(value), Vec3::splat(value))
    }
    pub fn from_rotation_x(angle: f32) -> Self {
        let (sin, cos) = angle.sin_cos();
        Self::from_axis(
            Vec3::new(1., 0., 0.),
            Vec3::new(0., cos, -sin),
            Vec3::new(0., sin, cos),
        )
    }
    pub fn from_rotation_y(angle: f32) -> Self {
        let (sin, cos) = angle.sin_cos();
        Self::from_axis(
            Vec3::new(cos, 0., sin),
            Vec3::new(0., 1., 0.),
            Vec3::new(-sin, 0., cos),
        )
    }
    pub fn from_rotation_z(angle: f32) -> Self {
        let (sin, cos) = angle.sin_cos();
        Self::from_axis(
            Vec3::new(cos, -sin, 0.),
            Vec3::new(sin, cos, 0.),
            Vec3::new(0., 0., 1.),
        )
    }
    pub fn from_translation(position: Vec2) -> Self {
        Self::from_axis(
            Vec3::new(1., 0., position.x),
            Vec3::new(0., 1., position.y),
            Vec3::new(0., 0., 1.),
        )
    }
    pub fn from_scale(scale: Vec2) -> Self {
        Self::from_axis(
            Vec3::new(scale.x, 0., 0.),
            Vec3::new(0., scale.y, 0.),
            Vec3::new(0., 0., 1.),
        )
    }
}

impl Add for Mat3 {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs.x_axis,
            y_axis: self.y_axis + rhs.y_axis,
            z_axis: self.z_axis + rhs.z_axis,
        }
    }
}

impl AddAssign<Mat3> for Mat3 {
    fn add_assign(&mut self, rhs: Self) {
        self.x_axis += rhs.x_axis;
        self.y_axis += rhs.y_axis;
        self.z_axis += rhs.z_axis;
    }
}

impl Add<f32> for Mat3 {
    type Output = Self;

    fn add(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis + rhs,
            y_axis: self.y_axis + rhs,
            z_axis: self.z_axis + rhs,
        }
    }
}

impl AddAssign<f32> for Mat3 {
    fn add_assign(&mut self, rhs: f32) {
        self.x_axis += rhs;
        self.y_axis += rhs;
        self.z_axis += rhs;
    }
}

impl Sub for Mat3 {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs.x_axis,
            y_axis: self.y_axis - rhs.y_axis,
            z_axis: self.z_axis - rhs.z_axis,
        }
    }
}

impl SubAssign<Mat3> for Mat3 {
    fn sub_assign(&mut self, rhs: Self) {
        self.x_axis -= rhs.x_axis;
        self.y_axis -= rhs.y_axis;
        self.z_axis -= rhs.z_axis;
    }
}

impl Sub<f32> for Mat3 {
    type Output = Self;

    fn sub(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis - rhs,
            y_axis: self.y_axis - rhs,
            z_axis: self.z_axis - rhs,
        }
    }
}

impl SubAssign<f32> for Mat3 {
    fn sub_assign(&mut self, rhs: f32) {
        self.x_axis -= rhs;
        self.y_axis -= rhs;
        self.z_axis -= rhs;
    }
}

impl Mul<f32> for Mat3 {
    type Output = Self;

    fn mul(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis * rhs,
            y_axis: self.y_axis * rhs,
            z_axis: self.z_axis * rhs,
        }
    }
}

impl MulAssign<f32> for Mat3 {
    fn mul_assign(&mut self, rhs: f32) {
        self.x_axis *= rhs;
        self.y_axis *= rhs;
        self.z_axis *= rhs;
    }
}

impl Mul for Mat3 {
    type Output = Self;

    fn mul(self, rhs: Self) -> Self::Output {
        let (a, d, g) = self.x_axis.unpack();
        let (b, e, h) = self.y_axis.unpack();
        let (c, f, i) = self.z_axis.unpack();

        let (j, m, p) = rhs.x_axis.unpack();
        let (k, n, q) = rhs.y_axis.unpack();
        let (l, o, r) = rhs.z_axis.unpack();
        Self {
            x_axis: Vec3 {
                x: a * j + b * m + c * p,
                y: d * j + e * m + f * p,
                z: g * j + h * m + i * p,
            },
            y_axis: Vec3 {
                x: a * k + b * n + c * q,
                y: d * k + e * n + f * q,
                z: g * k + h * n + i * q,
            },
            z_axis: Vec3 {
                x: a * l + b * o + c * r,
                y: d * l + e * o + f * r,
                z: g * l + h * o + i * r,
            },
        }
    }
}

impl MulAssign for Mat3 {
    fn mul_assign(&mut self, rhs: Self) {
        let (a, d, g) = self.x_axis.unpack();
        let (b, e, h) = self.y_axis.unpack();
        let (c, f, i) = self.z_axis.unpack();

        let (j, m, p) = rhs.x_axis.unpack();
        let (k, n, q) = rhs.y_axis.unpack();
        let (l, o, r) = rhs.z_axis.unpack();

        self.x_axis.x = a * j + b * m + c * p;
        self.x_axis.y = d * j + e * m + f * p;
        self.x_axis.z = g * j + h * m + i * p;

        self.y_axis.x = a * k + b * n + c * q;
        self.y_axis.y = d * k + e * n + f * q;
        self.y_axis.z = g * k + h * n + i * q;

        self.z_axis.x = a * l + b * o + c * r;
        self.z_axis.y = d * l + e * o + f * r;
        self.z_axis.z = g * l + h * o + i * r;
    }
}

impl Div<f32> for Mat3 {
    type Output = Self;

    fn div(self, rhs: f32) -> Self::Output {
        Self {
            x_axis: self.x_axis / rhs,
            y_axis: self.y_axis / rhs,
            z_axis: self.z_axis / rhs,
        }
    }
}

impl DivAssign<f32> for Mat3 {
    fn div_assign(&mut self, rhs: f32) {
        self.x_axis /= rhs;
        self.y_axis /= rhs;
        self.z_axis /= rhs;
    }
}

impl Mul<Vec3> for Mat3 {
    type Output = Vec3;

    fn mul(self, rhs: Vec3) -> Self::Output {
        let (x1, y1, z1) = self.x_axis.unpack();
        let (x2, y2, z2) = self.y_axis.unpack();
        let (x3, y3, z3) = self.z_axis.unpack();
        let (a1, a2, a3) = rhs.unpack();

        Vec3 {
            x: a1 * x1 + a2 * x2 + a3 * x3,
            y: a1 * y1 + a2 * y2 + a3 * y3,
            z: a1 * z1 + a2 * z2 + a3 * z3,
        }
    }
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
            "could not set `Mat3`s field `x_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(2i32, self.x_axis.y), |_| {
            "could not set `Mat3`s field `x_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(3i32, self.x_axis.z), |_| {
            "could not set `Mat3`s field `x_axis.z` of type `f32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(4i32, self.y_axis.x), |_| {
            "could not set `Mat3`s field `y_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(5i32, self.y_axis.y), |_| {
            "could not set `Mat3`s field `y_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(6i32, self.y_axis.z), |_| {
            "could not set `Mat3`s field `y_axis.z` of type `f32`"
        })?;

        mlua::ErrorContext::with_context(table.raw_set(7i32, self.z_axis.x), |_| {
            "could not set `Mat3`s field `z_axis.x` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(8i32, self.z_axis.y), |_| {
            "could not set `Mat3`s field `z_axis.y` of type `f32`"
        })?;
        mlua::ErrorContext::with_context(table.raw_set(9i32, self.z_axis.z), |_| {
            "could not set `Mat3`s field `z_axis.z` of type `f32`"
        })?;
        Ok(mlua::Value::Table(table))
    }
}

#[cfg(test)]
mod test {
    use crate::vec3::Vec3;

    use super::Mat3;
    #[test]
    fn matrix_x_vecor() {
        let m1 = Mat3::from_axis(
            Vec3::new(1., 4., 7.),
            Vec3::new(2., 5., 8.),
            Vec3::new(3., 6., 9.),
        );
        let vec = Vec3::new(1., 2., 3.);
        assert_eq!(m1*vec, Vec3::new(14.,32.,50.));
    }
    #[test]
    fn matrix_x_matrix() {
        let m1 = Mat3::from_axis(
            Vec3::new(1., 4., 7.),
            Vec3::new(2., 5., 8.),
            Vec3::new(3., 6., 9.),
        );
        let m2 = Mat3::from_axis(
            Vec3::new(9., 6., 3.),
            Vec3::new(8., 5., 2.),
            Vec3::new(7., 4., 1.),
        );
        assert_eq!(
            m1 * m2,
            Mat3::from_axis(
                Vec3::new(30., 84., 138.),
                Vec3::new(24., 69., 114.),
                Vec3::new(18., 54., 90.),
            )
        )
    }
}
