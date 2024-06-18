local L = require('visimp.language').new_language 'markdown'

function L.grammars()
  return { 'markdown', 'markdown_inline' }
end

function L.server()
  return 'marksman'
end

return L
