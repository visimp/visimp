local L = require('visimp.layer'):new_layer 'copilot'
local layer = require 'visimp.layer'

function L.packages()
  return {
    'github/copilot.vim',
  }
end

function L.load()
  layer.to_vimscript_config(L, 'copilot_', true)
end

return L
