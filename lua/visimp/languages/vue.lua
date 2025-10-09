local L = require('visimp.language'):new_language 'vue'

function L.grammars()
  return { 'vue', 'css', 'javascript' }
end

function L.server()
  return 'vue-language-server'
end

return L
