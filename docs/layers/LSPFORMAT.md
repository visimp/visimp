# `lspformat` layer

The `lspformat` layer adds conveniences for LSP formatting via the
[LSP-format.nvim](https://github.com/lukas-reineke/lsp-format.nvim) plugin.

## Configuration

The same as the one for `require("lsp-format").setup` documented
[here](https://github.com/lukas-reineke/lsp-format.nvim#how-do-i-use-format-options),
plus one additional patch option:

- `wq_fix` (default `true`) applies an autocommand to fix the behaviours when
  quitting and wiring. Because the formatter is async by default the code
  wouldn't be patched without this fix when wiring and closing the editor at the
  same time.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  lspformat = {
    typescript = {
      tab_width = function()
        -- the `indent` value you pass to the `default` layer is stored here
        return vim.opt.shiftwidth:get()
      end,
    },
    yaml = {
      tab_width = 2
    },
  },
})
```

## Documentation

The official documentation for the underlying plugin is available
[here](https://github.com/lukas-reineke/lsp-format.nvim).
