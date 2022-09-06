local L = require('visimp.layer').new_layer('haskell')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil which installs hls or can be
  -- disabled by setting it to false
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
  layers.get('treesitter').langs({ 'haskell' })

  -- Enable the language server
  if L.config.lsp ~= false then
    layers
      .get('lsp')
      .use_server(
        'haskell',
        L.config.lsp == nil,
        L.config.lsp or 'hls',
        L.config.lspconfig
      )
  end
end

return L
