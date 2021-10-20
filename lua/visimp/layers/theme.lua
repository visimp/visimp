local L = require('visimp.layer').new_layer('theme')
local opt = require('visimp.utils').opt

-- NOTE: in this context L.config is the theme function passed to lush
-- whereas L.theme is the lushified theme potentially used by other extensions

L.theme = nil
L.default_config = nil

function L.configure(theme)
  if theme == nil or theme == {} then
    error('No theme chosen')
  elseif type(theme) == 'table' then
    if #theme ~= 3 then
      error('Theme array must be of format {package, theme, colorscheme}')
    end
    L.package = theme[1]
    L.theme = theme[2]
    L.color = theme[3]
  elseif type(theme) == 'function' then
    L.lush = theme
  else 
    error('Invalid theme type: ' .. type(theme))
  end
end

function L.packages()
  return {{'rktjmp/lush.nvim', opt=true}}
end

function L.preload()
  if L.package ~= nil then
    package(L.package)
  end
end

function L.load()
  if L.lush ~= nil then
    vim.cmd('packadd lush.nivm')
    local ok, lush = pcall(require, 'lush')
    if not ok then
      error('Lush not installed:\n' .. lush)
    end

    L.theme = lush(L.lush(lush))
    lush(L.theme)
  elseif  L.package ~= nil then
    vim.cmd('colorscheme ' .. L.theme)
    opt('o', 'background', L.color)
  end
end

function L.get_theme()
  return L.theme
end

return L
