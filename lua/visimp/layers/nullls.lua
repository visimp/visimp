local L = require('visimp.layer').new_layer('nullls')
local get_module = require('visimp.bridge').get_module

-- List of null-ls builtins in the format `<builtin category>.<module>`. As an
-- example, to enable the prettier formatter add: `formatting.prettier`
L.default_config = {}

function L.packages()
  return {
    'nvim-lua/plenary.nvim',
    'jose-elias-alvarez/null-ls.nvim'
  }
end

function L.dependencies()
  return { 'lsp' }
end

function L.load()
  local nullls = get_module('null-ls')
  local sources = {}
  for _, mod in ipairs(L.config) do
    table.insert(sources, get_module(string.format('null-ls.builtins.%s', mod)))
  end
  nullls.setup({ sources = sources })
end

return L
