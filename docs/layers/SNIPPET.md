# `snippet` layer

The `snippet` layer allows you to define code snippets via the
[LuaSnip](https://github.com/l3mon4d3/luasnip) snippet engine. These may be
specified using VS Code syntax, SnipMate syntax, or directly in Lua.

## Bindings

- `<Tab>` in insert mode: after typing snippet trigger, expands the snippet;
- `<Tab>` in insert/selection mode: jumps to the next snippet stop;
- `<S-Tab>` (shift + tab) in insert/selection mode: jumps to the previous
  snippet stop;
- `<C-E>` (ctrl + e) in insert/selection mode: cycles through options for
  multiple choice snippet stops.

Bindings can be customized via the [`binds` layer](./BINDS.md).

## Configuration

- `setup`: setup settings for LuaSnip (as documented
  [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options));
- `loaders`: a table whose keys are snippet types (`lua`, `snipmate`, or
  `vscode`) for Lua to load from the filesystem, and values are the respective
  configurations (as described
  [here](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders)).

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
local ls = require("luasnip") -- snippets are defined as trees
local s = ls.snippet -- snippets constructor from trigger keyword and tree
local t = ls.text_node -- plaintext node 

return { -- this .lua file returns a list with just one snippet
  -- "lorem" will be expanded as plaintext, non-interactive snippet "Lorem
  -- ipsum dolor..."
  s("lorem", t("Lorem ipsum dolor sit amet, consectetur adipiscing elit."))
}
```

See the [documentation section](#documentation) to get familiar with LuaSnip.

## Layer-specific API

Other layers may interact with `snippet` via the following method.

### `add_snippets(ldr:string, opts:table or nil)`

A wrapper for [LuaSnip's lazy loading](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#api-2).
The first parameter is either "vscode", "snipmate", or "lua". The second
parameter is described in detail at the previous link.

```lua
local snippet = require('visimp.loader').get('snippet')

snippet.add_snippets('vscode', { paths = '~/.config/nvim/my_snippets' })
```

## Documentation

LuaSnip's README lists all kinds of [(un)official resources](https://github.com/l3mon4d3/luasnip?tab=readme-ov-file#documentation)
for beginners and experienced users, including:

- [LuaSnip's documentation](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md) (also available as `:help luasnip.txt`);
- [LuaSnip's Lua snippets examples](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua);
- [LuaSnip's wiki](https://github.com/L3MON4D3/LuaSnip/wiki).
