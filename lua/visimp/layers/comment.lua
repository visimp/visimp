local L = require('visimp.layer').new_layer('comment')
local get_module = require('visimp.utils').get_module

L.default_config = {}

function L.packages()
  return {'terrortylor/nvim-comment'}
end

function L.load()
  get_module('nvim_comment').setup(L.config or {})
end

return L
