local L = require('visimp.layer').new_layer 'theme'
local opt = require('visimp.bridge').opt

L.default_config = {
  package = 'gruvbox-community/gruvbox',
  colorscheme = 'gruvbox',
  background = 'dark',
  -- Optionally the following property can be set to change the lualine's theme.
  -- By default the colorscheme value is used
  -- lualine = 'gruvbox'

  -- Another option is to run functions before and after the theme is enabled.
  -- This is useful on certain themes to set settings (before) or overriding
  -- colors (after) when the theme doesn't provide an adequate settings for
  -- one's needs.
  before = function() end,
  after = function() end,
}

function L.packages()
  return { L.config.package }
end

function L.load()
  L.config.before()
  vim.cmd('colorscheme ' .. L.config.colorscheme)
  opt('o', 'background', L.config.background)
  L.config.after()
end

function L.get_theme()
  return L.config.lualine or L.config.colorscheme
end

return L
