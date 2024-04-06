local L = require('visimp.language').new_language 'lua'

function L.grammars()
  return { 'lua' }
end

function L.server()
  return 'lua_ls'
end

return L
