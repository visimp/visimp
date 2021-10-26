local L = require('visimp.layer').new_layer('languages')
local loader = require('visimp.loader')
local visimp = require('visimp.setup')

L.default_config = {}

function L.configure(cfg)
  vim.list_extend(L.config, cfg)

  for _, lang in ipairs(L.config) do
    local ok, ll = pcall(require, 'visimp.languages.' .. lang)
    if not ok then
      error(
        'Cannot find language: '
          .. lang
          .. ' (resolved to visimp.languages.'
          .. lang
          .. ')\n'
          .. ll
      )
    end

    loader.define_layer(ll)
  end

  -- Configure layers
  for _, l in ipairs(L.config) do
    local ll = loader.get(l)
    local cfg = visimp.configs[ll.identifier] or {}
    loader.get(l).configure(cfg)
  end
end

function L.packages()
  -- Load language packages
  for _, l in ipairs(L.config) do
    loader.get(l).packages()
  end
end

function L.preload()
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
