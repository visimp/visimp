local L = require('visimp.layer').new_layer 'idris'

function L.packages()
  return { 'edwinb/idris2-vim' }
end

function L.load()
  vim.cmd 'packadd idris2-vim'
end

return L
