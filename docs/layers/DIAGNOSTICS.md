# `diagnostics` layer

The `diagnostics` layer features "pretty lists for code diagnostics, references,
telescope results, quickfix and location lists" using
[Trouble](https://github.com/folke/trouble.nvim).

## Bindings

In normal mode:

- `<leader>xx` toggles diagnostics;
- `<leader>xX` toggles diagnostics for the current buffer only;
- `<leader>cs` toggles symbols list;
- `<leader>cl` toggles LSP definitions, references, and the like;
- `<leader>xL` toggles the [location list](https://neovim.io/doc/user/quickfix.html#location-list);
- `<leader>xQ` toggles the quickfix list.

## Configuration

- `trouble` (defaults to `{}`) can be any valid configuration for Trouble (whose
  settings and defaults are documented [here](https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration));
- `binds` (default bindings are documented above) as would be passed to the
  [`binds` layer](BINDS.md).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  diagnostics = {
    trouble = {
      warn_no_results = false,
      open_no_results = true,
      modes = {
        diagnostics = {
          auto_open = true,
          auto_close = true,
        },
      },
    },
  },
})
```

## Documentation

Full documentation for Trouble is available
[here](https://github.com/folke/trouble.nvim/blob/main/doc/trouble.nvim.txt).
