# `comment` layer (deprecated)

The `comment` layer provides support for (un)commenting code using
[Comment.nvim](https://github.com/numToStr/Comment.nvim). **It has been
deprecated since visimp v0.6.0 as nvim 0.10.0 now provides the same features
builtin. Thus, it will be removed soon.**


## Bindings

Default mappings are available at [Comment.nvim's "Configuration"
section](https://github.com/numToStr/Comment.nvim#configuration-optional).

## Configuration

See [Comment.nvim's "Configuration"
section](https://github.com/numToStr/Comment.nvim#configuration-optional).

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp") {
  comment = {
    -- Do not add a space b/w comment and the line
    padding = false,
    -- The cursor should not stay at its position
    sticky = false,
  },
}
```

## Documentation

Readme and docs for the original plugin are available [at its
repository](https://github.com/numToStr/Comment.nvim).
