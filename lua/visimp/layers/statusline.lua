local L = require('visimp.layer').new_layer('statusline')
local loader = require('visimp.loader')
local get_module = require('visimp.bridge').get_module

-- lualine modules
local mode = require('visimp.layers.statusline.mode')

L.default_config = {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { mode, separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

function L.dependencies()
  return { 'theme' }
end

function L.packages()
  return { 'nvim-lualine/lualine.nvim' }
end

--- Extracts a lualine theme from a lush config
-- @param theme A parsed lush theme
-- @return A lualine theme object
local function extract_from_lush(_)
  -- TODO: proper functionality
  return 'auto'
end

function L.load()
  local theme = loader.get('theme').get_theme()

  -- Attempt to load an existing lualine theme or use one generated from lush
  local ltheme = #theme >= 3 and (#theme >= 4 and theme[4] or 'auto')
    or extract_from_lush(theme)
  get_module('lualine').setup(
    vim.tbl_deep_extend('force', L.config, { options = { theme = ltheme } })
  )
end

return L
