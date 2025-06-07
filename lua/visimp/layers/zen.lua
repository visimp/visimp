local L = require('visimp.layer'):new_layer 'zen'
local get_module = require('visimp.bridge').get_module
local get_layer = require('visimp.loader').get
local opt = require('visimp.bridge').opt

L.default_config = {
  window = {
    width = 100,
  },
  on_open = function()
    local colorcolumn = get_layer('defaults').config.colorcolumn
    if colorcolumn ~= nil then
      opt('b', 'textwidth', colorcolumn)
      vim.opt.wrap = true
      vim.bo.formatoptions = vim.bo.formatoptions .. 'a'
    end
  end,
  on_close = function()
    opt('b', 'textwidth', 0)
    vim.opt.wrap = false
    vim.bo.formatoptions = vim.bo.formatoptions:gsub('a', '')
  end,
}

function L.dependencies()
  return { 'defaults' }
end

function L.packages()
  return {
    'folke/zen-mode.nvim',
  }
end

function L.load()
  get_module('zen-mode').setup(L.config)
end

return L
