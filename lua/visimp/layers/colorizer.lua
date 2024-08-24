local L = require('visimp.layer').new_layer 'colorizer'
local get_module = require('visimp.bridge').get_module

---All fields from https://github.com/NvChad/nvim-colorizer.lua#customization
L.default_config = {}

function L.packages()
  return { 'NvChad/nvim-colorizer.lua' }
end

function L.load()
  get_module('colorizer').setup(L.config or {})
end

return L
