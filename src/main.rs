use meth::apply;
use mlua::Lua;
use std::env;

fn main() -> mlua::Result<()> {
    let mut lua = Lua::new();
    apply(&mut lua).unwrap();

    lopa_test::apply(&lua)?;
    let args: Vec<_> = env::args().collect();
    if let Some(second) = args.get(1)
        && second == "--test"
    {
        lopa_test::execute_tests("src.lua.lopa-test", &lua)?;
    }

    Ok(())
}
