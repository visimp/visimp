---
title: Languages
---

# `languages` layer

The `languages` layer is in charge of loading languages layers. These usually
provide language-specific features such as:

- a language server;
- Tree-sitter parsers-based functionalities;
- language-specific additional plugins.

## Configuration

A list of [names of languages layers](../CONFIG.md#language-layers) as strings.
The order is not relevant.

Individual language layers need to be listed among the standard ones only when
you want to pass an explicit configuration. Language layers have two common
settings:

- `lsp`: the LS to use. Defaults to `nil`, meaning visimp will install one from
  Mason for you if possible. If set to a string, a preinstalled executable with
  such name will be looked up on the system. If set to false, no LS is run;
- `lspconfig`: if an LS is being used, the default LS-specific settings for it
  can be overwritten here.

Several language layers diverge from this basic configuration:

- `agda` and `ampl` do not have LSs on Mason, and thus can only be configured if
  a preinstalled executable is specified;
- `bash` adds the `fish` option (defaults to `false`) which, if set to true,
  adds support for the Fish shell;
- `c` adds the `c` and `cpp` options (both default to `true`) which enable
  support for both languages;
- `coq` has [its own doc page](../languages/quirks/COQ.md);
- `css` adds the `scss` option (defaults to `false`) which, if set to true,
  adds Tree-sitter support for SCSS;
- `dart` adds the `flutter` boolean option (defaults to `false`) and the
  `flutterconfig` table option for integration with the Flutter framework;
- `gleam` has [its own doc page](../languages/quirks/GLEAM.md);
- `hcl` adds the `terraform` boolean option (defaults to `true`) to indicate
  whether to use or disable the Terraform LS;
- `idris` has [its own doc page](../languages/quirks/IDRIS.md);
- `javascript` adds the `typescript` boolean option (defaults to `true`) to
  add Tree-sitter support for Typescript;
- `latex` add the `autocompile` (defaults to `true`) option for automatic
  compilation via LS and the `tectonic` (defaults to `false`) option to ask
  default LS Texlab to compile via Tectonic;
- `lean` has [its own doc page](../languages/quirks/LEAN.md);
- `prolog` and `toml` do not have LSs on Mason, and thus can only be configured
  if a preinstalled executable is specified.

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
