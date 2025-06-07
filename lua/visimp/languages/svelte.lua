local L = require('visimp.language'):new_language 'svelte'

function L.grammars()
  return { 'svelte' }
end

function L.server()
  return 'svelte'
end

return L
