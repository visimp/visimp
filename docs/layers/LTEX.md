# `ltex` layer

The `ltex` layer provides grammar checking by
[LanguageTool](https://languagetool.org) as an LS for markup documents
($\LaTeX$, Markdown, ...).

## Configuration

The same as the ones documented
[here](https://valentjn.github.io/ltex/settings.html). By default, visimp
sets 'ltex.language' to 'en-US'.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  ltex = {
    language = 'de-DE',
    dictionary = {
      "en-US": [
        "adaptivity",
        "precomputed",
        "subproblem"
      ],
      "de-DE": [
        "B-Splines",
        ":/path/to/externalFile.txt"
      ]
    },
  },
})
```

## Documentation

The official documentation for the underlying plugin is available
[here](https://valentjn.github.io/ltex/).
