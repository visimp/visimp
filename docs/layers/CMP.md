# `cmp` layer

The `cmp` layer is a dependency for other layers providing a completion engine
(namely, [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)).

## Bindings

In insert mode, with the suggestions list open:

- `<C-d>`: when selecting a suggestions, scrolls the documentation up;
- `<C-f>`: when selecting a suggestions, scrolls the documentation down;
- `<C-space>`: accepts suggestions;
- `<C-e>`: closes suggestions list;
- `<CR>`: accepts the selected suggestion;
- `<Tab>`: selects the next item in the list;
- `<S-Tab>`: selects the previous item in the list.

Bindings can be customized via the configuration.

## Configuration

- `buffer` (default `false`): whether autocomplete from the buffer or not;
- `lsp` (default `true`): whether autocomplete from the LSP suggestions;
- `lspkind` (default `true`): whether autocomplete from LSP symbols
  à-la-IntelliSense;
- `mappings` (see [Bindings](#bindings) for default): a table whose keys are
  binds as strings (e.g. `'<C-d>`) and values are handlers, much like the
  `cmp.mapping.preset.insert` method in
  [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp#recommended-configuration);
- `config` (default `{ experimental = { ghost_text = true } }`) configuration
  to be passed to `nvim-cmp`.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  cmp = {
    buffer = true -- autocomplete from the buffer
    config = {
      experimental = {
        ghost_text = false -- disable exprimental ghost text
      },
    },
  },
})
```

## Layer-specific API

Other layers may interact with `cmp` via the following methods.

### `add_source(source)`

Adds a new completion source, as defined in
[cmp.config.source](https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt).
The complete list is available [in the
wiki](https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources).

```lua
-- adds cmp-git for git-related completion
local snippet = require('visimp.loader').get('snippet')

cmp.add_source({ name = 'git' })

require('cmp_git').setup()
```

### `set_snippet(snippet)`

Sets the snippet engine to be used, as specified [in the
docs](https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt)


```lua
local snippet = require('visimp.loader').get('snippet')

snippet.set_snippet {
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end
}
```

## Documentation

The full documentation for the plugin is available
[here](https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt).
