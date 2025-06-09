---Configuration for the CSS layer
---@class CssConfig: LanguageConfig
---@field public scss boolean Whether SCSS support should be enabled

---@class CssLayer: LanguageLayer
---@field public default_config CssConfig
---@field public config CssConfig
local L = require('visimp.language'):new_language 'css'

L.default_config = {
  ---Enable SCSS support
  scss = false,
}

function L.grammars()
  if L.config.scss then
    return { 'css', 'scss' }
  end
  return { 'css' }
end

function L.server()
  return 'cssls'
end

return L
