local package = require('pak').register
local L = require('layer').new_layer('theme')

-- NOTE: in this context L.config is the theme function passed to lush
-- whereas L.theme is the lushified theme potentially used by other extensions

L.theme = nil
L.default_config = nil

function L.configure(theme)
  L.config = theme
end

function L.preload()
  package('rktjmp/lush.nvim')
end

function L.load()
  local ok, lush = pcall(require, 'lush')
  if not ok then
    error('Lush not installed:\n' .. lush)
  end
  if L.config == nil then
    error('No theme chosen')
  end

  L.theme = lush(L.config(lush))
  lush(L.theme)
end

function L.get_theme()
  return L.theme
end

return L
