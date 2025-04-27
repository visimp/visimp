local L = require('visimp.language').new_language 'idris'
local layer = require 'visimp.layer'

function L.packages()
  return { 'edwinb/idris2-vim' }
end

function L.grammars()
  return { 'idris' }
end

function L.server()
  return 'idris2_lsp'
end

function L.load()
  vim.cmd 'packadd idris2-vim'
  layer.to_vimscript_config(L, 'idris_', true)
end

return L
