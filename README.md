# ViSimp

The simp counterpart of NvChad

## Install

The installation of `visimp` requires the cloning of this code base and the
creation of a simple initial configuration, possibly starting from a template.

For UNIX-like system:
```sh
git clone --depth=1 https://github.com/lucat1/visimp.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paks/start/visimp
```

For Windows:
```sh
git clone https://github.com/lucat1/visimp.git "$env:LOCALAPPDATA\nvim-data\site\pack/paks/start/visimp"
```

Then create a neovim `init.lua` as follows:

```lua
local visimp = require('visimp')

visimp.configs = {
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
    'c', 'python'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
  theme = {'lifepillar/vim-gruvbox8', 'gruvbox8', 'dark'}
}
visimp.init()
```
