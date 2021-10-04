local L = require('layer').new_layer('languages')
local loader = require('loader')

L.default_config = {}
function L.configure(cfg)
  L.config = L.default_config
  cfg = cfg or {}
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
  for _, lang in ipairs(L.config) do
    loader.load(lang)
  end
end

return L
