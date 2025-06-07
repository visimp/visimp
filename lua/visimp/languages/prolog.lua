local L = require('visimp.language'):new_language 'prolog'

function L.filetypes()
  return {
    extension = {
      pl = 'prolog',
      pro = 'prolog',
      P = 'prolog',
    },
  }
end

function L.grammars()
  return { 'prolog' }
end

function L.server()
  return 'prolog_ls'
end

return L
