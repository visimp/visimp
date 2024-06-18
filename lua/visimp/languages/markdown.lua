local L = require('visimp.language').new_language 'markdown'

function L.grammars()
  return { 'markdown' }
end

function L.server()
  return 'marksman'
end

return L
