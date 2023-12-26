local L = require('visimp.layer').new_layer('agda')
local layers = require('visimp.loader')

L.default_config = {
  -- Leave to nil to use the official Agda Language Server, false to disable
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
  layers.get('treesitter').langs({ 'agda' })

  -- Enable the language server
  if L.config.lsp ~= false then
    -- Agda Language Server
  end
end

return L
