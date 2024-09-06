# `whichkey` layer

The `whichkey` layer provides a pop-up for possible key bindings for the command
you started typing via the [WhichKey plugin](https://github.com/folke/which-key.nvim).

## Configuration

Any [valid configuration for the WhichKey plugin](https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration)
can be passed to this layer.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  whichkey = {
    window = {
      border = "shadow", -- none, single, double, shadow
      position = "top", -- bottom, top
    }
  }
})
```

## Layer-specific API

### `add(mappings)`

Just a wrapper for `whichkey`'s `add` method. Under normal circumstances,
[there is no need to call this method or do anything
else](https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings) to have one's
mappings show up.
