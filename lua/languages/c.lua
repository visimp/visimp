local L = require('layer').new_layer('c')
local layers = require('loader')

L.default_config = {
  c = true,
  cpp = true
}

function L.dependencies()
  return {'treesitter'}
end

function L.load()
  local ts = layers.get('treesitter')
  local langs = {}
  print(vim.inspect(L.config))
  if L.config.c then
    table.insert(langs, 'c')
  end
  if L.config.cpp then
    table.insert(langs, 'cpp')
  end
  print('here')
  ts.langs(langs)
end

return L
