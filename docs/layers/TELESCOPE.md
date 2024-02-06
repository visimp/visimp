# `telescope` layer

The `telescope` layer adds
[`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim), a fuzzy
finder over lists, to your editor.

## Bindings

In normal mode:

- `<leader>p` find files by name;
- `<leader>f` searches through file content.

## Configuration

- `config` can be any valid configuration for `require('telescope.nvim').setup`
  as described [here](https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#customization);
- `binds` is a table of bindings passed in the `binds` layer format.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  telescope = {
    config = {
      pickers = {
        find_files = {
          theme = "dropdown",
        },
      },
    },
    binds = {
      [{
        mode = 'n',
        bind = '<leader>P',
        desc = 'Find new planets to explore',
      }] = 'planets',
    },
  },
})
```

## Documentation

Full documentation for telescope.nvim can be found
[here](https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt).
