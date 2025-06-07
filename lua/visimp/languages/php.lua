local L = require('visimp.language'):new_language 'php'

function L.grammars()
  return { 'php' }
end

function L.server()
  return 'phpactor'
end

return L
