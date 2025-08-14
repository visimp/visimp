local L = require('visimp.layer'):new_layer 'zotcite'
local get_module = require('visimp.bridge').get_module

---All fields from https://github.com/jalvesaq/zotcite are accepted here.
L.default_config = {}

function L.dependencies()
  return { 'telescope', 'cmp' }
end

function L.packages()
  return {
    { 'jalvesaq/zotcite', branch = 'typst' },
    { 'jalvesaq/cmp-zotcite', branch = 'typst' },
  }
end

function L.load()
  get_module('zotcite').setup(L.config or {})
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldenable = false
  table.insert(get_module('cmp').get_config().sources, { name = 'cmp_zotcite' })
end

return L
