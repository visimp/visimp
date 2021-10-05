local L = require('layer').new_layer('languages')
local loader = require('loader')
local init = require('.')

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
    local ok, module = pcall(require, 'languages.' .. lang)
    if not ok then
      error('Cannot find language: ' .. lang .. '\n' .. module)
    end

    loader.define_layer(module)
  end
end

function L.load()
  -- Configure layers
  for _, l in ipairs(L.config) do
    local ll = loader.get(l)
    local cfg = init.configs[ll.identifier] or {}
    loader.get(l).configure(cfg)
  end

  -- Preload languages
  for _, l in ipairs(L.config) do
    loader.preload(l)
  end

  -- Load languages
  for _, l in ipairs(L.config) do
    loader.load(l)
  end
end

return L
