local L = require('visimp.layer'):new_layer 'outline'
local get_module = require('visimp.bridge').get_module

---Same as: https://github.com/simrat39/symbols-outline.nvim#configuration
L.default_config = {}

L.deprecated = true

function L.packages()
  return { 'simrat39/symbols-outline.nvim' }
end

function L.load()
  get_module('symbols-outline').setup(L.config)
end

return L
