# `blankline` layer

The `blankline` layer adds indentation vertical guides using
[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).

## Configuration

See [indent-blankline.nvim docs's `config`
type](https://github.com/lukas-reineke/indent-blankline.nvim/blob/12e92044d313c54c438bd786d11684c88f6f78cd/doc/indent_blankline.txt).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  blankline = {
    debounce = 100, -- refresh is debounced by 100 ms
    indent = { char = "|" }, -- used to draw lines
    whitespace = { highlight = { "Whitespace", "NonText" } }, -- whitespace look
    scope = { exclude = { language = { "lua" } } }, -- hides scope in Lua
  },
})
```

## Documentation

Readme and docs for the original plugin are available [at its
repository](https://github.com/lukas-reineke/indent-blankline.nvim).
