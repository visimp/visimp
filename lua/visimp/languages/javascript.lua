local L = require('visimp.layer').new_layer 'javascript'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use tsserver LSP, otherwhise can specify a local executable
  -- or disable by setting to false.
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,

  -- Enable the typescript grammar
  typescript = true,
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
  local langs = { 'javascript' }
  if L.config.typescript then
    table.insert(langs, 'typescript')
  end
  layers.get('treesitter').langs(langs)

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'javascript',
      L.config.lsp == nil,
      L.config.lsp or 'tsserver',
      L.config.lspconfig
    )
  end
end

return L
