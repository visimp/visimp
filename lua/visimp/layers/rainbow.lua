local layer = require 'visimp.layer'
local L = layer:new_layer 'rainbow'
local get_module = require('visimp.bridge').get_module

function L.dependencies()
  return { 'treesitter' }
end

function L.packages()
  return {
    { url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git' },
  }
end

function L.load()
  get_module('rainbow-delimiters.setup').setup(L.config)
end

return L
