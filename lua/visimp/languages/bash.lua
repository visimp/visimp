---Configuration for the Bash layer
---@class BashConfig: LanguageConfig
---@field public fish boolean Whether Fish support should be enabled

---@class BashLayer: LanguageLayer
---@field public default_config BashConfig
---@field public config BashConfig
local L = require('visimp.language'):new_language 'bash'

L.default_config = {
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
