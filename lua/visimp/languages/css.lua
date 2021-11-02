local L = require('visimp.layer').new_layer('css')
local layers = require('visimp.loader')

L.default_config = {
  -- Leave to nil to use the cssls LSP, false to disable
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,

  -- Add the scss treesitter grammar
  scss = false,
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
  local langs = { 'css' }
  if L.config.scss then
    table.insert(langs, 'scss')
  end
  layers.get('treesitter').langs(langs)

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'css',
      L.config.lsp == nil,
      L.config.lsp or 'cssls',
      L.config.lspconfig
    )
  end
end

return L
