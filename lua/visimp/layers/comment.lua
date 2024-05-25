local L = require('visimp.layer').new_layer 'comment'
local get_module = require('visimp.bridge').get_module

L.default_config = {}

L.deprecated = true

function L.packages()
  return { 'numToStr/Comment.nvim' }
end

function L.load()
  get_module('Comment').setup(L.config or {})
end

return L
