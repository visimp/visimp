local L = require('visimp.language'):new_language 'nix'

function L.grammars()
  return { 'nix' }
end

function L.server()
  return 'nil_ls'
end

return L
