# `lspsignature` layer

The `lspsignature` layer shows function signature during typing via the
[lsp_signature](https://github.com/ray-x/lsp_signature.nvim) plugin.

## Configuration

The same as the one for `require("lsp_signature").setup` documented
[here](https://github.com/ray-x/lsp_signature.nvim#configure). By default,
vim uses the '>' character rather than the panda emoji.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  lspsignature = {
    -- show hint in a floating window, set to false for virtual text only mode
    floating_window = false,
  },
})
```

## Documentation

The official documentation for the underlying plugin is available
[here](https://github.com/ray-x/lsp_signature.nvim).
