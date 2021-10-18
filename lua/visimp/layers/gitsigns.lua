local L = require('visimp.layer').new_layer('gitsigns')
local loader = require('visimp.loader')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

L.default_config = {}

function L.preload()
  package('nvim-lua/plenary.nvim')
  package('lewis6991/gitsigns.nvim')
end

function L.load()
  get_module('gitsigns').setup(L.config)
end

return L
