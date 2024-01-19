# `diagnostics` layer

The `diagnostics` layer lists code diagnostics (errors, warnings, hints,
information...) using [Trouble](https://github.com/folke/trouble.nvim).

## Bindings

In normal mode:

- `<leader>xx` toggles diagnostics window;
- `<leader>xw` toggles workspace diagnostics;
- `<leader>xd` toggler document diagnostics;
- `<leader>xq` applies a quickfix;
- `<leader>xl` [location list](https://neovim.io/doc/user/quickfix.html#location-list).

## Configuration

- `trouble_config` a valid configuration for Trouble (whose settings and
  defaults are documented [here](https://github.com/folke/trouble.nvim#setup).
  Visimp does not feature
  [`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) out of
  the box, so `icons` is set to `false` by default by visimp;
- `binds` (default bindings are documented above) as would be passed to the
  [`binds` layer](BINDS.md) layer.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  diagnostics = {
    auto_open = true, -- open the list when you have diagnostics
    auto_close = true, -- close the list when you have no diagnostics
  },
})
```

## Documentation

Full documentation for Trouble is available
[here](https://github.com/folke/trouble.nvim/blob/main/doc/trouble.nvim.txt).
