# `rainbow` layer

The `rainbow` layer provides alternating syntax highlighting ("rainbow
parenthesis") for languages with a Treesitter parser installed. To do so, it
uses the [rainbow-delimiters.nvim
plugin](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/)

## Configuration

Any valid value for the `rainbow_delimiters` vimscript global variable ([see the
rainbow-delimites.nvim's "Setup" section](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/-/about))
is also a valid configuration for this layer. The `highlight` field might be
overwritten by the rainbow integration of the [`blankline` layer](./BLANKLINE.md).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  rainbow = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
    },
    priority = {
      [''] = 110,
      lua = 210,
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
  }
})
```

## Documentation

The full documentation for the plugin is available
[here](https://lab.vern.cc/gitlab.com/HiPhish/rainbow-delimiters.nvim/-/about).
