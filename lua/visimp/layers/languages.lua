local L = require('visimp.layer').new_layer('languages')
local loader = require('visimp.loader')
local visimp = require('visimp.setup')

L.default_config = {}
function L.configure(cfg)
  L.config = L.default_config
  cfg = cfg or {}
  -- merge the two arrays (default_config and cfg)
  for i = 1, #cfg do
    L.config[#L.default_config+1] = cfg[i]
  end
end

function L.preload()
  for _, lang in ipairs(L.config) do
    local ok, ll = pcall(require, 'visimp.languages.' .. lang) if not ok then error('Cannot find language: ' .. lang .. ' (resolved to visimp.languages.'
      .. lang .. ')\n' .. ll)
    end

    loader.define_layer(ll)
  end

  -- Configure layers
  for _, l in ipairs(L.config) do
    local ll = loader.get(l)
    local cfg = visimp.configs[ll.identifier] or {}
    loader.get(l).configure(cfg)
  end

  -- Preload languages
  for _, l in ipairs(L.config) do
    loader.preload(l)
  end
end

function L.load()
  -- Load languages
  for _, l in ipairs(L.config) do
    loader.load(l)
  end
end

return L
