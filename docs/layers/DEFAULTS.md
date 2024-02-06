# `defaults` layer

The `defaults` layer features sane Neovim defaults while still allowing for
customization.

## Configuration

- `mapleader` (default `' '`): leader bind;
- `relativenumber` (default `true`): whether enabling relative line numbers;
- `foldmethod` (default `nil`): if not `nil`, sets a fold method for the editor;  
- `indent` (default `2`): spaces per indentation;
- `scrolloff` (default `5`): lines to leave from the bottom when scrolling down;
- `sidescrolloff` (default `10`): lines to leave from the right when scrolling
   right;
- `colorcolumn` (default `80`): column where a colored, vertical column ruler is
   shown;
- `mousemodel` (default 'extend'): Neovim mouse model;
- `completeopt` (default 'menuone,noinsert,noselect'): Neovim completion
  options.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  defaults = {
    relativenumber = false,
    indent = 4,
  },
})
```
