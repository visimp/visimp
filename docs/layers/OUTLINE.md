# `outline` layer

The `outline` layer provides your editor with a tree-like view for symbols in
your buffer via
[symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim).

## Bindings

Described
[here](https://github.com/simrat39/symbols-outline.nvim#configuration).

## Configuration

Any valid configuration for `require('symbols-outline).setup` as documented
[here](https://github.com/simrat39/symbols-outline.nvim#configuration) is valid.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  nvimtree = {
    position = 'left',
    width = 30,
  },
})
```

## Documentation

The official documentation for the underlying plugin is available
[here](https://github.com/simrat39/symbols-outline.nvim).
