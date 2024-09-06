# `zen` layer

The `zen` layer offers a Zen mode in which most UI elements are hidden to
prevent distraction. To do so, it uses the [Zen Mode
plugin](https://github.com/folke/zen-mode.nvim).

## Configuration

Any [valid configuration for the Zen Mode plugin](https://github.com/folke/zen-mode.nvim#%EF%B8%8F-configuration)
can be passed to this layer. Visimp sets some defaults for you, too.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  zen = {
    backdrop = 1, -- no shading
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false -- disable whitespace characters
    }
  }
})
```
