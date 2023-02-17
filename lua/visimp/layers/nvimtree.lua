local L = require('visimp.layer').new_layer('nvimtree')
local get_module = require('visimp.bridge').get_module

-- for nvim-tree default config see https://github.com/nvim-tree/nvim-tree.lua
L.default_config = {
  icons = false
}

function L.packages()
  return {
    'nvim-tree/nvim-tree.lua',
  }
end

function L.dependencies()
  if L.config.icons then
    return { 'icons' }
  else
    return { }
  end

function L.load()
  get_module('nvim-tree').setup(L.config)
end

return L
