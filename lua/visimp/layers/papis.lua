local L = require('visimp.layer'):new_layer 'papis'
local get_module = require('visimp.bridge').get_module
local layers = require 'visimp.loader'

-- See https://github.com/jghauser/papis.nvim?tab=readme-ov-file#setup
L.default_config = {}

function L.dependencies()
  return { 'telescope', 'cmp', 'treesitter' }
end

function L.packages()
  return {
    'jghauser/papis.nvim',
    'kkharji/sqlite.lua',
    'MunifTanjim/nui.nvim',
    'pysan3/pathlib.nvim',
    'nvim-neotest/nvim-nio',
    'folke/snacks.nvim',
  }
end

function L.load()
  local tsLayer = layers.get 'treesitter' --[[@as TreesitterLayer]]
  tsLayer:langs { 'yaml' }

  get_module('papis').setup(L.config or {})
end

return L
