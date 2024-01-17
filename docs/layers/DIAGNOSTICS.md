# `diagnostics` layer

The `diagnostics` layer lists code diagnostics (errors, warnings, hints,
information...) using [Trouble](https://github.com/folke/trouble.nvim).

## Bindings

Default bindings can be consulted at [Trouble's "Setup"
section](https://github.com/folke/trouble.nvim#setup).

## Configuration

Configuration settings and default values can be consulted at [Trouble's "Setup"
section](https://github.com/folke/trouble.nvim#setup).

Visimp does not feature
[`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) out of the
box, so `icons` is set to `false`.

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

# "main" will be expanded as Haskell's main function. The editor will move to
# the end of the snippet (where the main function implementation should be),
# selecting the word "undefined", which acts as default implementation.
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
-- path/of/your/vim/config/init.lua

require("visimp")({
  diagnostics = {
    position = "top", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
  },
})
```

## Documentation

Full documentation for Trouble is available
[here](https://github.com/folke/trouble.nvim/blob/main/doc/trouble.nvim.txt).
