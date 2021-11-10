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

Then you can initialize a default config with the following command:
> WARNING: this will delete your previous `init.lua`
```sh
cp "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paks/start/visimp/_init.lua \
  "${XDG_CONFIG_HOME:-$HOME}"/.config/nvim/init.lua
```

Finally, edit the `init.lua` file you just copied to enable your desired
languages and configure any needed layer.
