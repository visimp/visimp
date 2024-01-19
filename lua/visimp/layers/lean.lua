local L = require('visimp.layer').new_layer 'lean'
local get_module = require('visimp.bridge').get_module

L.default_config = {
  abbreviations = {
    builtin = true,
  },
  mappings = true,
}

function L.dependencies()
  return {
    'lsp',
  }
end

function L.packages()
  return {
    'Julian/lean.nvim',
  }
end

function L.load()
  get_module('lean').setup(L.config)
end

return L
