local L = require('visimp.layer').new_layer('treesitter')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

L.default_config = {
  highlight = true,
  indent = true,
}

function L.preload()
  package('nvim-treesitter/nvim-treesitter')
end

function L.load()
  vim.cmd('packadd nvim-treesitter')

  local config = get_module('nvim-treesitter.configs')

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
  local ts = get_module('nvim-treesitter.install')
  ts.ensure_installed(lang)
end

return L
