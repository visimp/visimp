# Configuration

## Configuring `visimp`

You can configure your `visimp` installation from neovim's `init.lua` located
under your `$XDG_CONFIG_DIR/nvim`:

```lua
require 'visimp' {
  -- my (empty) visimp configuration
}
```

Requiring the `visimp` script returns a "setup" function. This procedure
is invoked by passing a description of your intended `visimp` configuration as
parameter. In the example above, we are using an empty object (`{}`) as our
configuration, so no layer is enabled, besides the default ones. If you want
to enable one, use its name as a new key (whose value will be an empty object
for now). The available layers are listed at [the bottom of this page](#available-layers). The following configuration enables the `autopairs`,
`gitsigns`, and `outline` layers:

```lua
require 'visimp' {
  autopairs = {},
  gitsigns = {},
  outline = {}
}
```

To disable a layer, you can either remove it from your configuration or use
`false` as its value. The latter is needed when the layer is enabled by default:

```lua
require 'visimp' {
  gitsigns = false, -- "gitsigns" is disabled: you may as well remove its entry
  
  lsp = false,      -- this line, on the contrary, is required as the layer
                    -- would be enabled by default
}
```

So far, we've stuck to empty objects as values for our enabled layers. These
objects actually represent your configuration for that specific layer. Usually,
each key is one of the settings available for the layer in question:

```lua
require 'visimp' {
  defaults = {             -- The "defaults" layer is enabled and should use:
    foldmethod = 'marker', -- - "marker" as its "foldmethod"
    tabsize = 4            -- - 4 as its "tabsize"
  }
}
```

When a setting isn't specified, its default value is used, and every setting has
a default value, so `{}` is always an acceptable configuration. Actually, some
layers accept a list of values instead of a key-value pairs configuration. The
main exception is the `languages` meta-layer:

```lua
require 'visimp' {
  languages = { -- accepts a list of languages for which support is needed.
    'c',
    'go',
    'latex',
    'rust'
  }
}
```

## Available Layers

### Standard Layers

Before configuring a new standard layer, you're advised to take a look at its
reference page. You can look it up in the following table.

| Layer name                               | Short description                                |
| ---------------------------------------- | ------------------------------------------------ |
| [`autopairs`](layers/AUTOPAIRS.md)       | Automatic completion of `{`, `(`, and HTML tags  |
| [`binds`](layers/BINDS.md)               | Custom bindings for native Vim commands          |
| [`blankline`](layers/BLANKLINE.md)       | Indentation guides                               |
| [`cmp`](layers/CMP.md)                   | Completion engine                                |
| [`colorizer`](layers/COLORIZER.md)       | Color highlighter                                |
| ~~[`comment`](layers/COMMENT.md)~~       | ~~Automatic (un)commenting support~~             |
| [`defaults`](layers/DEFAULTS.md)         | Customizable sane defaults                       |
| [`diagnostics`](layers/DIAGNOSTICS.md)   | Pretty list of diagnostics, quickfixes, and more |
| [`fugitive`](layers/FUGITIVE.md)         | Git wrapper                                      |
| [`gitsigns`](layers/GITSIGNS.md)         | Git code decorations                             |
| [`icons`](layers/ICONS.md)               | Adds file type icons                             |
| [`indentline`](layers/INDENTLINE.md)     | Whitespace characters visualization              |
| [`languages`](layers/LANGUAGES.md)       | Enable [language layers](#language-layers)       |
| [`lsp`](layers/LSP.md)                   | Manager for Neovim's LSP client and LSP servers  |
| [`lspformat`](layers/LSPFORMAT.md)       | Formatting on save via LSP                       |
| [`lspsignature`](layers/LSPSIGNATURE.md) | Function signatures as you type                  |
| [`ltex`](layers/LTEX.md)                 | Grammar checking via LanguageTool                |
| [`nvimtree`](layers/NVIMTREE.md)         | File explorer tree                               |
| [`outline`](layers/OUTLINE.md)           | Buffer outline as a tree-like view of symbols    |
| [`rainbow`](layers/RAINBOW.md)           | Rainbow parenthesis via Treesitter               |
| [`snippet`](layers/SNIPPET.md)           | Code snippets engine                             |
| [`statusline`](layers/STATUSLINE.md)     | Customizable status line                         |
| [`telescope`](layers/TELESCOPE.md)       | Fuzzy finder and related features                |
| [`theme`](layers/THEME.md)               | Install and enable classic vim themes            |
| [`treesitter`](layers/TREESITTER.md)     | Syntax highlighting                              |
| [`whichkey`](layers/WHICHKEY.md)         | Popups for key bindings suggestions              |
| [`zen`](layers/ZEN.md)                   | Distraction-free "zen" mode                      |

### Language layers

| Layer name                    | Language              |
| ----------------------------- | --------------------- |
| `agda`                        | Agda                  |
| `ampl`                        | AMPL                  |
| `bash`                        | Bash                  |
| `c`                           | C/C++                 |
| [`coq`](languages/COQ.md)     | Coq                   |
| `csharp`                      | C#                    |
| `css`                         | CSS                   |
| `dart`                        | Dart                  |
| [`gleam`](languages/GLEAM.md) | Gleam                 |
| `go`                          | Go                    |
| `haskell`                     | Haskell               |
| `hcl`                         | HCL                   |
| `html`                        | HTML                  |
| [`idris`](languages/IDRIS.md) | Idris                 |
| `java`                        | Java                  |
| `javascript`                  | JavaScript/TypeScript |
| `json`                        | JSON                  |
| `latex`                       | $\LaTeX$              |
| [`lean`](languages/LEAN.md)   | Lean                  |
| `lua`                         | Lua                   |
| `markdown`                    | Markdown              |
| `ocaml`                       | OCaml                 |
| `php`                         | PHP                   |
| `prolog`                      | (SWI-/GNU-/...)Prolog |
| `python`                      | Python                |
| `rust`                        | Rust                  |
| `svelte`                      | Svelte                |
| `swift`                       | Swift                 |
| `toml`                        | TOML                  |
| `typst`                       | Typst                 |
| `vue`                         | Vue                   |
