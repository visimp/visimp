local L = require('visimp.language'):new_language 'go'

function L.grammars()
  return { 'go' }
end

function L.server()
  return 'gopls'
end

return L
