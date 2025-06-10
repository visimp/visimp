local L = require('visimp.language'):new_language 'scheme'

function L.grammars()
  return { 'scheme' }
end

function L.server()
  return 'scheme_langserver'
end

return L
