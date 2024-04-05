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

function L.server()
  --[[ TODO:  06-04-24, Stefano Volpe foxy@teapot.ovh ]]
  return 'agda-language-server'
end

return L
