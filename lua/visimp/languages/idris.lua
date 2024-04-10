local layer = require 'visimp.layer'
local L = layer.new_layer 'idris'

function L.packages()
  return { 'edwinb/idris2-vim' }
end

function L.load()
  vim.cmd 'packadd idris2-vim'
  layer.to_vimscript_config(L, 'idris_', true)
end

return L
