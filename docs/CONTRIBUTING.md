# Contributing

Thanks for considering helping us out! This page lists the steps required to
contribute to the `visimp` project.

## Working on a feature/fixing a bug

Whether you are working on a new feature or fixing a bug, get in touch with the
project maintainers via the issue tracker. Please discuss the details of your
contribution together and make sure they are happy with it. This way, you will
not waste time on contributions that will be rejected.

## Reading the documentation

Before starting to work on your contribution, make sure you have read the
[Introduction](INTRO.md), [Config](CONFIG.md), and [Layer](LAYER.md) sections.

## Documenting

All tables and list in the documentation and in the sample configuration at
`_init.lua` should be presented in alphabetical order. Capitals letters should
be used uniformly.

### Working on internals

Update [Introduction](INTRO.md), [Config](CONFIG.md), and [Layer](LAYER.md) as
needed, if necessary.

### Working on a standard layer

When editing/adding a standard (i.e., non-language) layer, make sure the
respective documentation in `docs/layers` is up to date and referenced in the
corresponding table in [Config](CONFIG.md).

### Working on a language layer

When editing/adding a language layer, make sure it is listed in the
corresponding table in [Config](CONFIG.md). If your language layer includes
peculiar features specific to said language's platform (e.g., `coq`, `lean`),
the entry in the table should also link to a dedicated documentation page
in `docs/languages`.

If your language layer's configuration does not have precisely two fields `lsp`
and `lspconfig`(like most language layers do), document so in
[LANGUAGES](layers/LANGUAGES.md#configuration).

Make sure you language is listed in the sample configuration found in
`_init.lua`.

## Final checks

Before submitting your contribution, please run the following from the project's
root directory:

```bash
stylua . -- formatter
luacheck . -- linter
```

If your work is not properly formatted or contains linter warnings/error, the
respective automated tests will fail on your pull request.
