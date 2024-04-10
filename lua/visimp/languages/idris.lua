local L = require('visimp.language').new_language 'idris'
local layer = require 'visimp.layer'

function L.packages()
  return { 'edwinb/idris2-vim' }
end

--[[ TODO: https://github.com/mason-org/mason-registry/pull/5266 10-04-24,
-- Stefano Volpe foxy@teapot.ovh ]]
-- function L.server()
--   return 'idris2-lsp'
-- end

function L.load()
  vim.cmd 'packadd idris2-vim'
  layer.to_vimscript_config(L, 'idris_', true)
end

return L
