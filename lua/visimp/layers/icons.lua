local L = require('visimp.layer'):new_layer 'icons'
local get_module = require('visimp.bridge').get_module

---For nvim-web-devicons default config see
---https://github.com/nvim-tree/nvim-web-devicons#setup
L.default_config = {}

function L.packages()
  return {
    'nvim-tree/nvim-web-devicons',
  }
end

function L.load()
  get_module('nvim-web-devicons').setup(L.config)
end

return L
