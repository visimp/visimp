local L = require('visimp.language').new_language 'javascript'

L.default_config = {
  -- Enable the typescript grammar
  typescript = true,
}

function L.grammars()
  if L.config.typescript then
    return { 'javascript', 'typescript' }
  end
  return { 'javascript' }
end

function L.server()
  return 'tsserver'
end

return L
