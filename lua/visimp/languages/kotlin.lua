local L = require('visimp.language').new_language 'kotlin'

function L.grammars()
  return { 'kotlin' }
end

function L.server()
  return 'kotlin_language_server'
end

return L
