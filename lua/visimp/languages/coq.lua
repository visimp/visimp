local layer = require 'visimp.layer'
local L = layer.new_layer 'coq'

function L.packages()
  return { 'whonore/Coqtail' }
end

function L.load()
  vim.cmd 'packadd Coqtail'
  layer.to_vimscript_config(L, 'coqtail_', true)
end

return L
