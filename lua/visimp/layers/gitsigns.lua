local L = require('visimp.layer').new_layer('gitsigns')
local get_module = require('visimp.bridge').get_module

L.default_config = {}

function L.packages()
  return {
    'nvim-lua/plenary.nvim',
    'lewis6991/gitsigns.nvim',
  }
end

function L.load()
  get_module('gitsigns').setup(L.config)
end

return L
