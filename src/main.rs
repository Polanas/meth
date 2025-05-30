use meth::apply;
use mlua::Lua;

fn main() {
    let mut lua = Lua::new();
    apply(&mut lua).unwrap();
    lua.load(include_str!("lua/meth/test.lua")).exec().unwrap();
}
