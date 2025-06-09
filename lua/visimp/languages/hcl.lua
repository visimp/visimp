---Configuration for the Hcl layer
---@class HclConfig: LanguageConfig
---@field public terraform boolean Whether Terraform support should be enabled

---@class HclLayer: LanguageLayer
---@field public default_config HclConfig
---@field public config HclConfig
local L = require('visimp.language'):new_language 'hcl'

L.default_config = {
  terraform = true,
}

function L.grammars()
  if L.config.terraform then
    return { 'hcl', 'terraform' }
  end
  return { 'hcl' }
end

function L.server()
  return 'terraformls'
end

return L
