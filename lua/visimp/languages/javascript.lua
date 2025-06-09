---Configuration for the JavaScript layer
---@class JavaScriptConfig: LanguageConfig
---@field public typescript boolean Whether TypeScript support should be enabled

---@class JavaScriptLayer: LanguageLayer
---@field public default_config JavaScriptConfig
---@field public config JavaScriptConfig
local L = require('visimp.language'):new_language 'javascript'

L.default_config = {
  typescript = true,
}

function L.grammars()
  if L.config.typescript then
    return { 'javascript', 'typescript' }
  end
  return { 'javascript' }
end

function L.server()
  return 'ts_ls'
end

return L
