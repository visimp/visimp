local L = require('visimp.language').new_language 'gleam'

function L.grammars()
  return { 'gleam' }
end

function L.server()
  return 'gleam'
end

return L
