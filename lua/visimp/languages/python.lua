local L = require('visimp.language').new_language 'python'

function L.grammars()
  return { 'python' }
end

function L.server()
  return 'pyright'
end

return L
