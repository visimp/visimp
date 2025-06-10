---@class ThemeLayer: Layer
local L = require('visimp.layer'):new_layer 'theme'
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

function L:packages()
  return { self.config.package }
end

function L:load()
  self.config.before()
  vim.cmd('colorscheme ' .. L.config.colorscheme)
  opt('o', 'background', L.config.background)
  self.config.after()
end

function L:get_theme()
  return self.config.lualine or self.config.colorscheme
end

return L
