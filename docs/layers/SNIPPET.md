# `snippet` layer

The `snippet` layer allows you to define code snippets via the
[LuaSnip](https://github.com/l3mon4d3/luasnip) snippet engine. These may be
specified using VS Code syntax, SnipMate syntax, or directly in Lua.

## Configuration

- `setup`: setup settings for LuaSnip (as documented
  [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options));
- `loaders`: a table whose keys are snippet types (`lua`, `snipmate`, or
  `vscode`) for Lua to load from the filesystem, and values are the respective
  configurations (as described
  [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders)).

## Layer-specific methods

- `add_snippets(ft:string or nil, snippets:list or table, opts:table or nil)`:
  wrapper for the homonym function from [LuaSnip's API](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#api-2).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  snippet = {
    setup = { -- LuaSnip setup configuration
      update_events = { "TextChanged", "TextChangedI" },
    },
    loaders = {
      -- load SnipMate-like snippets from
      -- path/of/your/vim/config/snippets/. See below for an example.
      snipmate = {}
      -- load VS-Code-like snippets from any directory in your Neovim's
      -- `runtimepath` containing at least one VS-Code-like package.json
      -- contributing snippets. See
      -- https://github.com/rafamadriz/friendly-snippets as an example.
      vscode = {},
      -- load snippets defined in Lua from
      -- path/of/your/vim/config/luasnippets/. See below for an example.
      lua = {},
    },
  },
})
```

```snippets
# path/of/your/nvim/config/snippets/haskell.snippets
snippet main
  main :: IO ()
  main = ${0:undefined}
```

```lua
-- path/of/your/nvim/config/luasnippets/all.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
return {
  s("lorem", t("Lorem ipsum dolor sit amet, consectetur adipiscing elit."))
}
```

## Documentation

LuaSnip's README lists all kinds of [(un)official resources](https://github.com/l3mon4d3/luasnip?tab=readme-ov-file#documentation)
for beginners and experienced users.
