local L = require('visimp.layer'):new_layer 'copilot'

function L.packages()
  return {
    'github/copilot.vim',
  }
end

return L
