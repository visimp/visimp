local L = require('visimp.layer').new_layer 'c'

L.default_config = {
  c = true,
  cpp = true,
}

function L.preload()
  local langs = {}
  if L.config.c then
    table.insert(langs, 'c')
  end
  if L.config.cpp then
    table.insert(langs, 'cpp')
  end
  return langs
end

function L.server()
  return 'clangd'
end
