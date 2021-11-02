local L = require('visimp.layer').new_layer('ocaml')
local layers = require('visimp.loader')

L.default_config = {
  -- Leave to nil to use the ocamlls LSP, false to disable
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server lspconfig = nil
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
  layers.get('treesitter').langs({ 'ocaml' })

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'ocaml',
      L.config.lsp == nil,
      L.config.lsp or 'ocamls',
      L.config.lspconfig
    )
  end
end

return L
