local L = require('visimp.layer').new_layer 'fugitive'

L.default_config = {}
L.deprecated = true

function L.packages()
  return { 'tpope/vim-fugitive' }
end

function L.preload()
  vim.cmd 'packadd vim-fugitive'
end

return L
