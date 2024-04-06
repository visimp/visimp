local L = require('visimp.language').new_language 'agda'

function L.filetypes()
  return {
    extension = {
      agda = 'agda',
      ['agda-lib'] = 'agda',
      lagda = 'lagda',
    },
  }
end

function L.grammars()
  return { 'agda' }
end

-- function L.server()
--[[ TODO: https://github.com/mason-org/mason-registry/pull/5263 06-04-24,
             Stefano Volpe foxy@teapot.ovh ]]
--   return 'agda-language-server'
-- end

return L
