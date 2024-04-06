local L = require('visimp.language').new_language 'haskell'

function L.grammars()
  return { 'haskell' }
end

function L.server()
  return 'hls'
end

return L
