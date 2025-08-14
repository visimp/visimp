local L = require('visimp.layer'):new_layer 'papis'
local get_module = require('visimp.bridge').get_module
local layers = require 'visimp.loader'

L.default_config = {
  init_filetypes = { 'markdown', 'norg', 'yaml', 'typst' },
}

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
  get_module('papis').setup(L.config or {})
  local tsLayer = layers.get 'treesitter' --[[@as TreesitterLayer]]
  tsLayer:langs { 'yaml' }
end

return L
