local L = require('visimp.layer').new_layer('treesitter')
local get_module = require('visimp.utils').get_module

L.default_config = {
  highlight = true,
  indent = true,
}
L.languages = {}

function L.packages()
  return { 'nvim-treesitter/nvim-treesitter' }
end

function L.load()
  local config = get_module('nvim-treesitter.configs')
  config.setup({
    highlight = {
      enable = L.config.highlight,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = L.config.indent },
  })

  local ts = get_module('nvim-treesitter.install')
  ts.ensure_installed(L.languages)
end

-- Ensures the given tree sitter parsers are installed
-- @param languages The array of languages to check
function L.langs(languages)
  vim.list_extend(L.languages, languages)
end

return L
