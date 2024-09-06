# `greeter` layer

The `greeter` layer enables the user to customize the default Neovim greeter via 
[alpha-nvim](https://github.com/goolord/alpha-nvim).

## Configuration
The layer can be configured with a custom layout object providing the necessary
details for `alpha-nvim` to render the greeting. 

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
    greeter = {
        layout = {
            -- alpha nvim layout object here
        }
    }
})
```

For further explanation on the layout object itself, refer to the following 
examples and the official `alpha-nvim` repository. In particular, be sure to
read the FAQs to prevent unwanted interactions with other features.

## Examples

### `alpha-nvim` default themes
In the following example `alpha-nvim`'s default _dashboard_ theme is used.

```lua
-- path/of/your/vim/config/init.lua

-- use alpha-nvim's default 'dashboard' theme
local dashboard = require('alpha.themes.dashboard').opts

require("visimp")({
    greeter = {
        layout = dashboard,
    }
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
    greeter = {
        layout = my_wonderful_theme(),
    },
})
```
