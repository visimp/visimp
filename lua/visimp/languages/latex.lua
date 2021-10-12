local L = require('visimp.layer').new_layer('latex')
local layers = require('visimp.loader')
local get_module = require('visimp.utils').get_module

-- TODO: add latex language server
L.default_config = {}

function L.dependencies()
  return {'treesitter'}
end

function L.preload()
  -- Configure treesitter
  local ts = layers.get('treesitter')
  ts.langs({'latex'})
end
