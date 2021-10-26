local L = require('visimp.layer').new_layer('statusline')
local loader = require('visimp.loader')
local get_module = require('visimp.utils').get_module

L.default_config = {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
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
function extract_from_lush(theme)
  -- TODO: proper functionality
  return 'auto'
end

function L.load()
  local theme = loader.get('theme').get_theme()

  -- Attempt to load an existing lualine theme or use one generated from lush
  local ltheme = #theme >= 3 and (#theme >= 4 and theme[4] or 'auto')
    or extract_from_lush(ltheme)
  get_module('lualine').setup(
    vim.tbl_deep_extend('force', L.config, { theme = ltheme })
  )
end

return L
