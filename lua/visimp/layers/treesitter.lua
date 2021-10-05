local L = require('visimp.layer').new_layer('treesitter')
local package = require('visimp.pak').register

local function get_module(mod)
  local ok, ts = pcall(require, 'nvim-treesitter.' .. mod)
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
end

function L.load()
  local ts = get_module('configs')

  ts.setup({
    highlight = { enable = L.config.highlight },
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
