local L = require('visimp.layer').new_layer('treesitter')
local package = require('visimp.pak').register

local function get_module(mod)
  local ok, ts = pcall(require, 'nvim-treesitter' .. (mod and '.' .. mod or ''))
  if not ok then
    error('TreeSitter not installed:\n' .. ts)
  end
  return ts
end

L.default_config = {
  highlight = true,
  indent = true,
}

function L.preload()
  package('nvim-treesitter/nvim-treesitter')

  -- load the needed vimscript section of treesitter
  vim.cmd('packadd nvim-treesitter')
end

function L.load()
  local config = get_module('configs')

  config.setup({
    highlight = {
      enable = L.config.highlight,
      additional_vim_regex_highlighting = false
    },
    indent = { enable = L.config.indent }
  })
end

-- Ensures the given tree sitter parsers are installed
-- @param lang The array of languages to check
function L.langs(lang)
  local ts = get_module('install')
  ts.ensure_installed(lang)
end

return L
