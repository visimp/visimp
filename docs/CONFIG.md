# Configuration

## Configuring `visimp`

You can configure your `visimp` installation from `init.lua`:

```lua
require('visimp')({
  -- my (empty) visimp configuration
})
```

Requiring the `visimp` script returns a "setup" function object. This procedure
is invoked passing a description of your intended `visimp` configuration as
parameter. In the example above, we are using an empty object (`{}`) as our configuration,
so no layer is enabled. If you want to enable one, use its name as a new key
(whose value will be an empty object for now). The available layers are listed
at the bottom of this page. The following configuration enables the `autopairs`,
`gitsigns`, and `outline` layers:

```lua
require('visimp')({
  autopairs = {},
  gitsigns = {},
  outline = {}
})
```

To disable a layer, you can either remove it from your configuration or use
`false` as its value:

```lua
require('visimp')({
  autopairs = {},
  gitsigns = false, -- "gitsigns" is disabled: you may as well remove its entry
  outline = {}
})
```

So far, we've sticked to empty objects as values for our enabled layers. These
objects actually represent your configuration for that specific layer. Usually,
each key is one of the settings available for the layer in question:

```lua
require('visimp')({
  defaults = {             -- The "defaults" layer is enabled and should use:
    foldmethod = 'marker', -- - "marker" as its "foldmethod"
    tabsize = 4            -- - 4 as its "tabsize"
  }
})
```

When a setting isn't specified, its default value is used, and every setting has
a default value, so `{}` is always an acceptable configuration. Actually, some
layers accept a list of values instead of a key-value pairs configuration. Here
are some of these notable exceptions:

```lua
require('visimp')({
  languages = { -- accepts a list of languages for which support is needed.
    'c',
    'go',
    'latex',
    'rust'
  },
  theme = { -- accepts three theming parameters (in this order):
    'lifepillar/vim-gruvbox8', -- theme's GitHub "username/repository"
    'gruvbox8',                -- theme's name
    'dark'                     -- either "dark" or "bright"
  }
})
```

Before configuring a new layer, you're advised to take a look at its reference
page. You can look it up in the tables presented in the next section.

## Available Layers

### Standard Layers

| Layer name                               | Short description                                |
| ---------------------------------------- | ------------------------------------------------ |
| [`autopairs`](layers/AUTOPAIRS.md)       | Automatic completion of `{`, `(`, and HTML tags  |
| [`binds`](layers/BINDS.md)               | Custom bindings for native Vim commands          |
| [`blankline`](layers/BLANKLINE.md)       | Indentation guides                               |
| [`cmp`](layers/CMP.md)                   | Completion engine                                |
| [`comment`](layers/COMMENT.md)           | Automatic (un)commenting support                 |
| [`defaults`](layers/DEFAULTS.md)         | Customizable sane defaults                       |
| [`diagnostics`](layers/DIAGNOSTICS.md)   | Pretty list of diagnostics, quickfixes, and more |
| [`fugitive`](layers/FUGITIVE.md)         | Git wrapper                                      |
| [`gitsigns`](layers/GITSIGNS.md)         | Git code decorations                             |
| [`grammarly`](layers/GRAMMARLY.md)       | Grammarly writing assistant support              |
| [`languages`](layers/LANGUAGES.md)       | Enable language layers                           |
| [`lsp`](layers/LSP.md)                   | Neovim's LSP client and LSPs manager             |
| [`lspformat`](layers/LSPFORMAT.md)       | Formatting on save via LSP                       |
| [`lspsignature`](layers/LSPSIGNATURE.md) | Function signatures as you type                  |
| [`outline`](layers/OUTLINE.md)           | Buffer outline as a tree-like view of symbols    |
| [`snippet`](layers/SNIPPET.md)           | Code snippet engine                              |
| [`statusline`](layers/STATUSLINE.md)     | Customizable status line                         |
| [`telescope`](layers/TELESCOPE.md)       | Fuzzy finder and related features                |
| [`theme`](layers/THEME.md)               | Lush theme loader or classic Vim theme manager   |
| [`treesitter`](layers/TREESITTER.md)     | Syntax highlighting                              |
| [`whichkey`](layers/WHICHKEY.md)         | Popups for key bindings suggestions              |

### Language layers

| Layer name                         | Language   |
| ---------------------------------- | ---------- |
| [`ampl`](lang/AMPL.md)             | AMPL       |
| [`bash`](lang/BASH.md)             | Bash       |
| [`c`](lang/C.md)                   | C          |
| [`csharp`](lang/CSHARP.md)         | C#         |
| [`css`](lang/CSS.md)               | CSS        |
| [`dart`](lang/DART.md)             | Dart       |
| [`go`](lang/GO.md)                 | Go         |
| [`haskell`](lang/HSKELL.md)        | Haskell    |
| [`html`](lang/HTML.md)             | HTML       |
| [`java`](lang/JAVA.md)             | Java       |
| [`javascript`](lang/JAVASCRIPT.md) | JavaScript |
| [`json`](lang/JSON.md)             | JSON       |
| [`latex`](lang/LATEX.md)           | $\LaTeX$   |
| [`lua`](lang/LUA.md)               | Lua        |
| [`ocaml`](lang/OCAML.md)           | OCaml      |
| [`php`](lang/PHP.md)               | PHP        |
| [`python`](lang/PYTHON.md)         | Python     |
| [`rust`](lang/RUST.md)             | Rust       |
| [`toml`](lang/TOML.md)             | TOML       |
| [`vue`](lang/VUE.md)               | Vue        |
