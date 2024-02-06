# `autopairs` layer

The `autopairs` layer provides automatic completions of "{", "(", various other
characters, and HTML tags via
[nvim-autopairs](https://github.com/windwp/nvim-autopairs).

## Configuration

- `cmp_integration` (default `true`): integration with the completion plugin;
- `html` (default `true`): HTML tags autocompletion;
- all fields from
  [nvim-autopairs](https://github.com/windwp/nvim-autopairs#default-values) are
  also accepted.

## Examples

```lua
-- path/of/your/vim/config/init.lua

require("visimp")({
  autopairs = {
    html = false, -- disable HTML tags autocompletion
    map_c_h = true  -- from nvim-autopairs: map the <C-h> key to delete a pair
  },
})
```

## Documentation

Full documentation is available at
[nvim-autopairs](https://github.com/windwp/nvim-autopairs).
