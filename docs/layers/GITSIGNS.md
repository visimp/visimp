# `gitsigns` layer

The `gitsigns` layer allows you to use git from within vim via the
[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) plugin.

## Configuration

Any [valid configuration for
gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim#installation--usage)
can also be passed to the `gitsigns` layer.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  gitsigns = {
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
  },
})
```

## Documentation

The full gitsigns.nvim documentation is available
[here](https://github.com/lewis6991/gitsigns.nvim/blob/main/doc/gitsigns.txt).
