local L = require('visimp.language').new_language 'json'

function L.grammars()
  return { 'json' }
end

function L.server()
  return 'jsonls'
end

return L
