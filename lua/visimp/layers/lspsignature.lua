local L = require('visimp.layer').new_layer('lspsignature')
local get_module = require('visimp.utils').get_module

L.default_config = {
  hint_prefix = '> ',
}

function L.dependecies()
  return { 'lsp' }
end

function L.packages()
  return { 'ray-x/lsp_signature.nvim' }
end

function L.load()
  get_module('lsp_signature').setup(L.config or {})
end

return L
