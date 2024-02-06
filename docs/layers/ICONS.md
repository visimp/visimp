# `icons` layer

The `icons` layer adds icons to the TUI interfaces provided by the other layers
via the [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
plugin.

## Configuration

Any [valid configuration for
nvim-web-devicon](https://github.com/nvim-tree/nvim-web-devicons?tab=readme-ov-file#setup)
can also be passed to the `icons` layer.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  icons = {
   -- all icons will have the default icon's color
   color_icons = false;
   -- globally enable default icons
   default = true;
  },
})
```

## Documentation

The full nvim-web-devicons documentation is available
[here](https://github.com/nvim-tree/nvim-web-devicons?tab=readme-ov-file).
