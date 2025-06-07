local L = require('visimp.language'):new_language 'rust'

function L.grammars()
  return { 'rust' }
end

function L.server()
  return 'rust_analyzer'
end

return L
