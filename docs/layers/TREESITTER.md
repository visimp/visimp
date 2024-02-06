# `treesitter` layer

The `treesitter` layer is a dependency layer providing languages layers with
Treesitter support.

## Configuration

- `highlight` (default `true`): whether to enable syntax highlighting;
- `indent` (default `true`): whether to enable automatic indentation.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  treesitter = {
    highlight = false,
    indent = false
  }
})
```

## Layer-specific API

### `langs(languages)`

This method ensures the treesitter parsers passed as a list of strings
(`languages`) are installed.
