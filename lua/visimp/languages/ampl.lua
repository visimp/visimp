local L = require('visimp.language'):new_language 'ampl'

function L.filetypes()
  return {
    extension = {
      mod = 'ampl',
    },
  }
end

return L
