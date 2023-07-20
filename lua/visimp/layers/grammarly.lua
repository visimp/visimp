-- DEPRECATED
local L = require('visimp.layer').new_layer('grammarly')
local layers = require('visimp.loader')

-- Optional configuration to be provided for the language server
-- All fields from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#grammarly
-- are accepted here.
L.default_config = {}

function L.dependencies()
  return { 'lsp' }
end

function L.preload()
  layers.get('lsp').use_server('grammarly', true, 'grammarly', L.config or {})
end

function L.load()
  print(
    'The `grammarly` layer is deprecated and shall not be used. Please disable it.'
  )
end

return L
