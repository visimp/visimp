# `alphanvim` layer

The `alphanvim` layer enables the user to customize the default Neovim greeter using
[alpha-nvim](https://github.com/goolord/alpha-nvim).

## Configuration
The layer can be configured with a layout object that provides the necessary details
for `alpha-nvim` to render the greeting. For further explaination, refer to the
plugin official repository and examples.

## Examples

### `alpha-nvim` default themes
In the following example `alpha-nvim`'s default _dashboard_ theme is used.

```lua
-- path/of/your/vim/config/init.lua

-- use alpha-nvim's default 'dashboard' theme
local dashboard = require('alpha.themes.dashboard').opts

require("visimp")({
    alphanvim = dashboard,
})
```

### Themes from scratch
One can also define a new theme for scratch.
```lua
-- path/of/your/vim/config/init.lua

function my_wonderful_theme()
    local header = {
        type = "text",
        val = {
            "visimp is cool!"
        },
        opts = {
            position = "center",
            hl = "Type",
        },
    }

    return {
        layout = {
            header
        },
    }
end

require("visimp")({
    alphanvim = my_wonderful_theme(),
})
```
