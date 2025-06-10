local L = require('visimp.language'):new_language 'swift'

function L.grammars()
  return { 'swift' }
end

function L.server()
  return 'sourcekit'
end

return L
