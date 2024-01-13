local L = require('visimp.layer').new_layer 'rust'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use the phpactor LSP, false to disable, a string to use a
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
  layers.get('treesitter').langs { 'rust' }

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'rust',
      L.config.lsp == nil,
      L.config.lsp or 'rust_analyzer',
      L.config.lspconfig
    )
  end
end

return L
