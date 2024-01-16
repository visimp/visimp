local L = require('visimp.layer').new_layer 'go'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use the gopls LSP, false to disable, a string to use a
  -- local binary
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,
}

function L.dependencies()
  local deps = { 'treesitter' }
  if L.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.preload()
  -- Configure treesitter
  layers.get('treesitter').langs { 'go' }

  -- Enable the language server
  if L.config.lsp ~= false then
    local install = L.config.lsp == nil
    local server = L.config.lsp or 'gopls'
    local settings = L.config.lspconfig
    layers.get('lsp').use_server('go', install, server, settings)
  end
end

return L
