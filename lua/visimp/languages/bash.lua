local L = require('visimp.language').new_language 'bash'

L.default_config = {
  -- Enable fish support (fish being a superset of bash)
  fish = false,
}

function L.grammars()
  if L.config.fish then
    return { 'bash', 'fish' }
  end
  return { 'bash' }
end

function L.server()
  return 'bashls'
end

return L
