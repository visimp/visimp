local L = require('visimp.layer').new_layer 'blankline'
local get_module = require('visimp.bridge').get_module

-- See https://github.com/lukas-reineke/indent-blankline.nvim#setup for more
L.default_config = {}

function L.packages()
  return { 'lukas-reineke/indent-blankline.nvim' }
end

function L.load()
  get_module('ibl').setup(L.config or {})
end

return L
