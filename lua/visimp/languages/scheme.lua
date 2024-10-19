local L = require('visimp.language').new_language 'scheme'

function L.filetypes()
  return {
    extension = {
      scm = 'scheme',
      ss = 'scheme',
    },
  }
end

function L.grammars()
  return { 'scheme' }
end

return L
