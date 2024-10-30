---
weight: 10
---

# `coq` layer

The `coq` layer enables support for the Coq proof assistant/programming
language via [Coqtail](https://github.com/whonore/Coqtail). This plugin's
documentation specifies its requirements.

## Bindings

Mappings are available [in the "Usage" section of Coqtail](https://github.com/whonore/Coqtail#usage)

## Configuration

Any vim **global** variable that [the "Configuration" section of Coqtail](https://github.com/whonore/Coqtail#configuration)
states can be set to configure Coqtail is also a valid field for this layer's
config, as long as you strip the `coqtail_` prefix.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  coq = {
    indent_on_dot = 1 -- do not use the coqtail_ prefix
  },
  languages = {
    "coq"
  }
})
```

## Documentation

The full documentation for the plugin is available
[here](https://github.com/whonore/Coqtail/blob/main/doc/coqtail.txt).
