# `binds` layer

The `binds` layer allows you to define custom bindings declaratively.

## Configuration

This layer's configuration is an array. Each key is a table, and must have the
following fields:

 - `mode`: mode short name ([see `{mode}`](https://neovim.io/doc/user/lua.html#vim.keymap.set(%29)));
 - `bind`: binding trigger ([see `{lhs}`](https://neovim.io/doc/user/lua.html#vim.keymap.set(%29)));
 - `opts`: additional (non-mandatory) options ([see `{opts}`](https://neovim.io/doc/user/lua.html#vim.keymap.set(%29))).
   Should contain `desc`, a description of the binding (used by the [`whichkey`
   layer](WHICHKEY.md)).

Each value is a function to be invoked when the binding is triggered.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  binds = {
    [{
      mode = 'n',                   -- When in normal mode...
      bind = '<leader>h',           -- and pressing <leader>h...
      opts = {
        desc = 'Show date and time' -- (description for whichkey layer)
      }
    }] = function ()
      print(os.date())              -- ...print the current date and time
    end
  }
})
```
