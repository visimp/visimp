# `statusline` layer

The `statusline` layer offers a new statusline, namely
[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).

## Configuration

A lualine.nvim configuration as described
[here](https://github.com/nvim-lualine/lualine.nvim#usage-and-customization).

Visimp sets a handful of reasonable defaults for you from `options`, `sections`,
and `inactive_sections`.

If no `theme` option is explicitly passed, visimp will fetch the theme from the
`theme` layer for you.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  statusline = {
    extensions = {
      'quickfix'} -- enable extensions
    },
    tabline = { -- add tabline 
      lualine_a = {buffers},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {tabs},
    }
  },
})
```

## Documentation

Full documentation for the underlying plugin can be found
[here](https://github.com/nvim-lualine/lualine.nvim/blob/master/doc/lualine.txt).
