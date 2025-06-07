local L = require('visimp.language'):new_language 'java'

function L.grammars()
  return { 'java' }
end

function L.server()
  return 'jdtls'
end

return L
