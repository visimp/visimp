local L = require('visimp.layer'):new_layer 'zotcite'
local get_module = require('visimp.bridge').get_module

---All fields from https://github.com/windwp/nvim-autopairs#default-values
---are accepted here. Extra fields are `cmp_integration` and `html`, and default
---to true.
L.default_config = {
  bib_and_vt = {
    markdown = true,
    pandoc = false,
    vimwiki = false,
    rmd = false,
    quarto = false,
    typst = true,
    latex = true,
    rnoweb = true,
  },
}

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
