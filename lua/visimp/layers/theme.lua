local L = require('visimp.layer').new_layer('theme')
local opt = require('visimp.bridge').opt

L.default_config = {
  package = 'gruvbox-community/gruvbox',
  colorscheme = 'gruvbox',
  background = 'dark',
  -- Optionally the following property can be set to change the lualine's theme.
  -- By default the colorscheme value is used
  -- lualine = 'gruvbox'
}

function L.packages()
  return { L.config.package }
end

function L.load()
  vim.cmd('colorscheme ' .. L.config.colorscheme)
  opt('o', 'background', L.config.background)
end

function L.get_theme()
  return L.config.lualine or L.config.colorscheme
end

return L
