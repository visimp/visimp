# `agda` layer

The `agda` layer enables support for the Agda proof assistant/programming
language via:
- [`cornelis` interactive development](https://github.com/isovector/cornelis);
- integration with the [`treesitter`](../layers/TREESITTER.md) layer.

## Prerequisites

To use `cornelis`, you have to invoke `stack build` to generate its binary
within the corresponding plugin folder. This should be
`${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paks/start/cornelis`.
Alternatively, if you want to use a binary available on your `$PATH`, you can
set `cornelis.use_global_binary` to `1`.

As no language server for Agda is currently available on Mason, you need to
install one yourself on your system.

## Bindings

All the sample bindings and autocommands listed in `cornelis`'s [sample
configuration](https://github.com/isovector/cornelis#example-configuration) are
available out of the box as default bindings.

## Configuration

Some fields are available:
- `cornelis` (`table`) configures `cornelis`'s behavior. Any vim **global**
  variable listed [in Cornelis's README](https://github.com/isovector/cornelis)
  is also a valid subfield for this field as long as you strip the `cornelis_`
  prefix;
- `binds` (default bindings as explained above) is a list of bindings for
  `cornelis`, as would be passed to the [`binds` layer](BINDS.md) layer;
- the usual `lsp` and `lspconfig` fields [shared by most language layers
  configurations](../layers/LANGUAGES.md#configuration) are also available.
  However, Agda does not have a language server on Mason, and thus these can
  only be configured if `lsp` specifies a preinstalled executable for the
  language server.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  agda = {
    cornelis = {
      split_location = 'vertical' -- different position for info window
    },
    bindings = { -- add a new Cornelis binding
      [{
        mode = 'n',
        bind = '<leader>nm',
        desc = 'Expand ?-holes to "{! !}"',
      }] = function() vim.cmd("CornelisQuestionToMeta") end,
    },
    lsp = "als", -- Agda Language Server executable installed by the user
    lspconfig = {
      -- config for the Agda Language Server
    },
  },
  languages = {
    "agda"
  }
})
```

## Documentation

Documentation for `cornelis` is available within [its own
README.md](https://github.com/isovector/cornelis).
