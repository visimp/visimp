# `colorizer` layer

The `colorizer` layer highlights colors names/codes in buffers using
[nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua).

## Configuration

See [nvim-colorizer.lua "customization" section
type](https://github.com/NvChad/nvim-colorizer.lua#customization).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp") {
  colorizer = {
    user_default_options = {
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "foreground", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      tailwind = true, -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
    },
  },
}
```

## Documentation

Readme and docs for the original plugin are available [at its
repository](https://github.com/NvChad/nvim-colorizer.lua).
