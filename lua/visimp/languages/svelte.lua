local L = require('visimp.layer').new_layer 'svelte'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use the default svelte LSP, false to disable
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
  layers.get('treesitter').langs { 'svelte' }

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'svelte-language-server',
      L.config.lsp == nil,
      L.config.lsp or 'svelte',
      L.config.lspconfig
    )
  end
end

return L
