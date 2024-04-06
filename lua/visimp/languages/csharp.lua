local L = require('visimp.language').new_language 'csharp'

L.default_config = {
  -- Enable fish support (fish being a superset of bash)
  fish = false,
}

function L.grammars()
  local langs = { 'bash' }
  if L.config.fish then
    table.insert(langs, 'fish')
  end
  return langs
end

function L.server()
  return 'bashls'
end

return L
