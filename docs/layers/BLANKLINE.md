# `blankline` layer

The `blankline` layer adds indentation vertical guides using
[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).

## Configuration

- `indent_blankline` (`table`): a valid configuration for the
  `indent-blankline.nvim` plugin, as described in the relevant docs's [`config`
  type](https://github.com/lukas-reineke/indent-blankline.nvim/blob/12e92044d313c54c438bd786d11684c88f6f78cd/doc/indent_blankline.txt);
- `rainbow_integration` (`table`): if set to a false-ish value, it disables
  integration with the [`rainbow` layer](./RAINBOW.md) even when the latter is
  enabled. Otherwise, it must be a list of tables describing [highlight groups](https://neovim.io/doc/user/syntax.html#highlight-groups)
  to be shared by the `blankline` and `rainbow` layers. Said tables are ordered
  by the outmost to the innermost highlight group to be used for indentation
  vertical guides and parentheses. Each table has the following field:
  - `name` (`string`): the name of the highlight group;
  - `fg` (`string`): a hex code in the form `#RRGGBB` to be used as foreground
    color for the highlighting. No background color will be set for the
    highlighting of indentation vertical guides and rainbow parentheses.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  indent_blankline = {
    debounce = 100, -- refresh is debounced by 100 ms
    indent = { char = "|" }, -- used to draw lines
    whitespace = { highlight = { "Whitespace", "NonText" } }, -- whitespace look
    scope = { exclude = { language = { "lua" } } }, -- hides scope in Lua
  },
  rainbow_integration = {
    {
      name = 'RainbowWhite',
      fg = '#FFFFFF',
    },
  },
})
```

## Documentation

Readme and docs for the original plugin are available [at its
repository](https://github.com/lukas-reineke/indent-blankline.nvim).
