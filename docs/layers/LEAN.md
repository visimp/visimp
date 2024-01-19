# `lean` layer

The `lean` layer enables support for the lean proof assistant/programming
language via [lean.nvim](https://github.com/Julian/lean.nvim). Having Lean
installed is a prerequisite.

## Bindings

Mappings are listed [in the "Mappings" section of lean.nvim](https://github.com/Julian/lean.nvim#mappings)

## Configuration

By default, visimp enables builtin abbreviations and mappings.
In general, every valid argument for `require('lean').setup` ([as shown here](https://github.com/Julian/lean.nvim/wiki/Configuring-&-Extending))
is a valid configuration.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp") {
  lean = {
    abbreviations = {
        builtin = false -- disable builtin abbreviations
    },
    mappings = false, -- disable mappings
  }
}
```

## Documentation

The full documentation for the plugin is available
[here](https://github.com/whonore/Coqtail/blob/main/doc/coqtail.txt).
