local L = require('visimp.layer').new_layer('outline')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

-- Same as: https://github.com/simrat39/symbols-outline.nvim#configuration
L.default_config = {}

function L.preload()
  package('simrat39/symbols-outline.nvim')
end

function L.load()
  get_module('symbols-outline').setup(L.config)
end

return L
