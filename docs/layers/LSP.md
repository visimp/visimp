# `lsp` layer

The `lsp` layer configures the Nvim LSP client via
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig). It is a dependency
for layers requiring LSPs, such as most language layers.

LSs are installed by [mason.nvim](https://github.com/williamboman/mason.nvim)
by default.

Neovim itself can also act as an LS to inject new LSP-like features via
[none-ls.nvim](https://github.com/nvimtools/none-ls.nvim), a community fork of
the discontinued "null-ls.nvim". All documentation and code still refer to
null-ls, as none-ls does not rename its API for compatibility concerns.

## Bindings

In normal mode:

- `gD` goes to declaration;
- `gd` does to definition;
- `K` shows hover;
- `gi` goes to implementation;
- `<C-K>` shows signature help;
- `<leader>D` shows type definition;
- `<leader>rn` renames the current symbol;
- `<leader>ca` runs a code action;
- `<gr>` goes to references;
- `<leader>e` show line diagnostics;
- `[d` goes to previous diagnostic;
- `]d` does to next diagnostic;
- `gf` formats the current buffer.

## Configuration

- `install` (default `true`): whether Mason should attempt to install language
  servers when none are explicitly specified;
- `progess` (default `{}`): if nil, LSP progress reports are disabled;
- `mason` (default `{}`): a valid [Mason config](https://github.com/williamboman/mason.nvim?tab=readme-ov-file#configuration);
- `nullls` (default `{}`): strings used as keys are considered null-ls source
  names, and their values the respective configs. When non-strings are used as
  keys (e.g. implicit number indices in arrays), their values are assumed to be
  null-ls source names w/o configs;
- `binds` (default as above): bindings as would be passed to the `binds` layer;

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  nullls = {
    'code_actions.gitsigns',
    ['formatting.latexindent'] = {
      extra_args = { '-m' },
    },                   -- LaTeX
    'formatting.stylua', -- Lua
  },
})
```

## Layer-specific API

Other layers (mostly language layers) may interact with `lsp` via the
following methods.

### `use_server(lang:string, install:boolean, srv:string, settings:table)`

Enables an LSP sever at startup, where:

- `lang` is the name of the language (used by Mason);
- `install` is `true` if the server should be installed via Mason;
- `srv` is the name of the server executable (if any);
- `settings` are any optional settings for the language server.

```lua
layers.get('lsp').use_server('go', true, 'gopls', {})
```

### `on_attach(fn:function)`

Adds an "on-attach"-like handler to be invoked when LSs get enabled for a
buffer.

### `on_attach_one_time(fn:function)`

Adds an "on-attach"-like handler to be invoked each time a buffer sees an LS
enabled for the first time.

### `get_callbacks()`

Returns the list of "on-attach"-like handlers.

### `get_callbacks_one_time()`

Returns the list of "on-attach-one-time"-like handlers.

### `get_capabilities()`

Returns the capabilities' handler.

## Documentation

You are encouraged to read the documentation for `nvim-lspconfig`, `mason.nvim`,
and `nulls.nvim`. These projects are linked at the beginning of this page.
