local L = require('visimp.layer'):new_layer 'lean'

L.default_config = {
  abbreviations = {
    builtin = true,
  },
  mappings = true,
}

function L.dependencies()
  return { 'lsp' }
end

function L.packages()
  return { 'Julian/lean.nvim' }
end

function L.load()
  vim.g.lean_config = L.config
end

return L
