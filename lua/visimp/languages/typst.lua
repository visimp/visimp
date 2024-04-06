local L = require('visimp.language').new_language 'typst'

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
