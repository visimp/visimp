local L = require('visimp.language'):new_language 'csharp'

function L.grammars()
  return { 'c_sharp' }
end

function L.server()
  return 'omnisharp'
end

return L
