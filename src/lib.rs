pub mod vec2;
pub mod vec3;
pub mod vec4;

pub mod mat2;
pub mod mat3;
pub mod mat4;

pub fn apply(lua: &mut mlua::Lua) -> mlua::Result<()> {
    lua.load(
        r"
local inner = _G['__inner']
local inner = inner ~= nil and inner or {}
inner.meth = {}
_G['__inner'] = inner
        ",
    )
    .exec()?;
    lua.load(include_str!("lua/meth/vec2.lua")).exec()?;
    lua.load(include_str!("lua/meth/ivec2.lua")).exec()?;
    lua.load(include_str!("lua/meth/vec3.lua")).exec()?;
    lua.load(include_str!("lua/meth/ivec3.lua")).exec()?;
    lua.load(include_str!("lua/meth/vec4.lua")).exec()?;
    lua.load(include_str!("lua/meth/ivec4.lua")).exec()?;
    lua.load(include_str!("lua/meth/mat2.lua")).exec()?;
    lua.load(include_str!("lua/meth/mat3.lua")).exec()?;
    lua.load(include_str!("lua/meth/mat4.lua")).exec()?;

    // lua.load(include_str!("lua/meth/test.lua")).exec()?;
    Ok(())
}
