local L = require('visimp.language'):new_language 'typst'

function L.grammars()
  return { 'typst' }
end

function L.server()
  return 'tinymist'
end

return L
