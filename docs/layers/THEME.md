# `theme` layer

The `theme` layer is tasked with setting a theme.

## Configuration

- `package` (default `'gruvbox-community/gruvbox'`) is the theme repository.
  Could be either be a table with a `url` string field or a string to be
  appended to `'https://github.com/'`;
- `colorscheme` (default `'gruvbox'`) is the colorscheme name;
- `background` (default `dark`) is equivalent to Neovim's `background` option;
- `lualine` (default `nil`) can be set to a second colorscheme for the
  statusline layer. If `nil`, `lualine` is used;
- `before` is a 0-parameters handler to be invoked right before the theme is
  enabled (e.g. initialize theme settings);
- `after` is a 0-parameters handler to be invoked right after the theme is
  enabled (e.g. override theme colors).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  theme = {
    package = {
      url = 'https://codeberg.org/foxy/reddish-fox.nvim.git',
    },
    colorscheme = 'reddish-fox',
    background = 'dark',
  },
})
```

## Layer-specific API

### `get_theme()`

Returns the name of the desired statusline colorscheme, i.e. the value of the
`lualine` setting or, if not set, the value of the `colorscheme` setting.

This method is used by the `statusline` layer.
