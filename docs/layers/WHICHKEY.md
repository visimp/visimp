# `whichkey` layer

The `whichkey` layer provides a popup for possible key bindings for the command
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

### `register(binds)`

Makes all values in `binds` available to which-key. Each value is a bind as
those described by the [`binds` layer's "Configuration"
section](BINDS.md#configuration).

### `register_all()`

This method ensures all keybindings are registered. It is also run when a new
LSP layer is attached to a buffer.
