local L = require('visimp.language'):new_language 'html'

function L.grammars()
  return { 'html' }
end

function L.server()
  return 'html'
end

return L
