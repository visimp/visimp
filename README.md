# `visimp`

The simp counterpart of NvChad. See the
[documentation](https://visimp.teapot.ovh).

```sh
# Unix-like
git clone --depth=1 https://github.com/visimp/visimp.git \
  "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paks/start/visimp
```

```sh
# Windows
git clone https://github.com/visimp/visimp.git "$env:LOCALAPPDATA\nvim-data\site\pack/paks/start/visimp"
```

```sh
# This will replace your previous `init.lua` with a visimp config
mkdir -p "${XDG_DATA_HOME:-$HOME}"/.config/nvim
cp "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paks/start/visimp/_init.lua \
  "${XDG_DATA_HOME:-$HOME}"/.config/nvim/init.lua
```
