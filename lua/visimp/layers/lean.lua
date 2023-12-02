local L = require('visimp.layer').new_layer('lean')
local get_module = require('visimp.bridge').get_module

L.default_config = {
  mappings = true,
}

function L.dependencies()
  return {}
end

function L.packages()
  return {
    'Julian/lean.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
  }
end

function L.load()
  vim.cmd('packadd nvim-lspconfig')
  vim.cmd('packadd plenary.nvim')
  vim.cmd('packadd lean.nvim')
  get_module('lean').setup(L.config)
end

return L
