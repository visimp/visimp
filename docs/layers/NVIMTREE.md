# `nvimtree` layer

The `nvimtree` layer provides your editor with a new file explorer, namely
[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).

## Bindings

Described
[here](https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt).

## Configuration

Any valid configuration for `require('nvim-tree').setup` as documented
[here](https://github.com/nvim-tree/nvim-tree.lua#setup), plus one optional
field:

- `icons` (defaults to `false`) whether to enable file/directory icons. Requires
  the [`icons` layer](ICONS.md).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  icons = {}, -- required when nvimtree.icons is true
  nvimtree = {
    -- visimp setting
    icons = true,
    -- nvim-tree settings
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  },
})
```

## Documentation

The official documentation for the underlying plugin is available
[here](https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt).
