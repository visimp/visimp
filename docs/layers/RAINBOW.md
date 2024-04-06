# `rainbow` layer

The `rainbow` layer provides alternating syntax highlighting ("rainbow
parenthesis") for languages with a Treesitter parser installed. To do so, it
uses the [rainbow-delimiters.nvim
plugin](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/)

## Configuration

This layer cannot be configured via visimp at the moment. Please refer to [the
rainbow-delimites.nvim's "Setup" section](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/-/about)
instead.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  rainbow = {} -- cannot be configured via visimp
})

vim.g.rainbow_delimiters.query.lua = 'rainbow-blocks'
```

## Documentation

The full documentation for the plugin is available
[here](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/-/about).
