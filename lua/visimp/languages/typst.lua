local L = require('visimp.language').new_language 'typst'

L.default_config = {
  -- Optional configuration to be provided for the chosen language server
  lspconfig = {
    exportPdf = 'onType',
  },
}

function L.filetypes()
  return {
    extension = {
      typ = 'typst',
    },
  }
end

function L.grammars()
  return { 'typst' }
end

function L.server()
  return 'typst_lsp'
end

return L
