local L = require('visimp.layer').new_layer 'rainbow'
local get_module = require('visimp.bridge').get_module

function L.dependencies(l)
  return { 'treesitter' }
end

function L.packages()
  return {
    { url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git' },
  }
end

function L.load()
  get_module 'rainbow-delimiters'
end

return L
