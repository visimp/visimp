# `languages` layer

The `languages` layer is in charge of loading languages layers. These usually
provide language-specific features such as:

- a language server;
- Treesitter parsers-based functionalities;
- language-specific additional plugins.

## Configuration

A list of [names of languages layers](../CONFIG.md#language-layers) as strings.
The order is not relevant.

Some languages which are often used as proof assistants (e.g. Coq, Lean) are
supported as standard layers rather than language layers, and are documented as
such.

Individual language layers need to be listed among the standard ones only when
you want to pass an explicit configuration. Language layers have two commoon
settings:

- `lsp`: the LS to use. Defaults to `nil`, meaning visimp will install one from
  Mason for you if possible. If set to a string, a preinstalled executable with
  such name will be looked up on the system. If set to false, no LS is run;
- `lspconfig`: if an LS is being used, the default LS-specific settings for it
  can be overwritten here.

Several language layers diverge from this basic configuration:

- `agda` and `ampl` do not have LSP support at all, and thus cannot be
  configured;
- `bash` adds the `fish` option (defaults to `false`) which, if set to true,
  adds support for the Fish shell;
- `c` adds the `c` and `cpp` options (both default to `true`) which enable
  support for both languages;
- `css` adds the `scss` option (defaults to `false`) which, if set to true,
  adds Treesitter support for SCSS;
- `dart` adds the `flutter` boolean option (defaults to `false`) and the
  `flutterconfig` table option for integration with the Flutter framework;
- `hcl` adds the `terraform` boolean option (defaults to `true`) to indicate
  whether to use or disable the Terraform LS;
- `javascript` adds the `typescript` boolean option (defaults to `true`) to
  add Treesitter support for Typescript;
- `latex` add the `autocompile` (defaults to `true`) option for automatic
  compilation via LS and the `tectonic` (defaults to `false`) option to ask
  default LS Texlab to compile via Tectonic;
- `toml` does not have LSP support at all, and thus cannot be configured;

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  languages = {
   'go', -- we only list Go in the languages config as we like its defaults
   'latex',
  },
  latex = {
    -- Uses an externally managed LS rather than installing one from Mason
    lsp = 'texlab',
    -- LS-specific config https://github.com/latex-lsp/texlab/wiki/Configuration
    lspconfig = {
      texlab = {
        build = {
          executable = 'pdflatex',
        },
      },
    },
    -- Unlike lsp and lspconfig, this setting is specific to this language layer
    autocompile = false,
  },
})
```
