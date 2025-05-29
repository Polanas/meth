use vec2::Vec2;
use vec4::{IVec4, UVec4, Vec4};

pub mod vec2;
pub mod vec3;
pub mod vec4;

pub fn apply(lua: &mut mlua::Lua) -> mlua::Result<()> {
    lua.load(include_str!("meth/vec2.lua")).exec()?;
    lua.load(include_str!("meth/ivec2.lua")).exec()?;
    lua.load(include_str!("meth/vec3.lua")).exec()?;
    lua.load(include_str!("meth/ivec3.lua")).exec()?;
    lua.load(include_str!("meth/vec4.lua")).exec()?;
    lua.load(include_str!("meth/ivec4.lua")).exec()?;
    Ok(())
}
