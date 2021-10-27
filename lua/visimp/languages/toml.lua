local L = require('visimp.layer').new_layer('toml')
local layers = require('visimp.loader')

L.default_config = {}

function L.dependencies()
  return { 'treesitter' }
end

function L.preload()
  -- Configure treesitter
  layers.get('treesitter').langs({ 'toml' })
end

return L
