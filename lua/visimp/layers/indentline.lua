local L = require('visimp.layer').new_layer('indentline')
local get_module = require('visimp.bridge').get_module

-- All fields from https://github.com/NvChad/nvim-colorizer.lua#customization
L.default_config = {}

function L.packages()
  return { 'lukas-reineke/indent-blankline.nvim' }
end

function L.load()
  get_module('indent_blankline').setup(L.config or {})
end

return L
