local L = require('visimp.layer').new_layer 'statusline'
local loader = require 'visimp.loader'
local get_module = require('visimp.bridge').get_module

-- lualine modules
local mode = require 'visimp.layers.statusline.mode'

L.default_config = {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = {
      { 'filename', symbols = { modified = ' +', readonly = '' } },
    },
    lualine_c = { 'location', 'progress' },
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'branch' },
  },
  inactive_sections = {
    lualine_a = { mode },
    lualine_b = {
      { 'filename', symbols = { modified = ' +', readonly = '' } },
    },
    lualine_c = { 'location' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

function L.dependencies()
  return { 'theme' }
end

function L.packages()
  return { 'nvim-lualine/lualine.nvim' }
end

function L.load()
  -- Respect the theme setting if imposed
  if not L.config.options.theme then
    local theme = loader.get('theme').get_theme()
    local ok, _ = pcall(get_module('lualine.utils.loader').load_theme, theme)
    if not ok then
      theme = 'auto'
    end
  end

  get_module('lualine').setup(vim.tbl_deep_extend('force', L.config, {
    options = {
      theme = theme,
    },
  }))
end

return L
