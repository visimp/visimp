local L = require('layer').new_layer('theme')

L.theme = nil
L.default_config = nil

function L.packages()
  print('called')
  return {'rktjmp/lush.nvim'}
end

function L.on_load(theme)
  local ok, lush = pcall(require, 'lush')
  if not ok then
    error('Lush not installed')
  end
  if theme == nil then
    error('No theme chosen')
  end

  L.theme = lush(theme)
  lush(L.theme)
end

L.get_theme = function()
  return L.theme
end

return L
