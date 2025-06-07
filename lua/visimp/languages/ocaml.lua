local L = require('visimp.language'):new_language 'ocaml'

function L.grammars()
  return { 'ocaml' }
end

function L.server()
  return 'ocamllsp'
end

return L
