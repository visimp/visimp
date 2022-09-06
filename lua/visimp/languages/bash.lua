local L = require('visimp.layer').new_layer('bash')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil(bashls via lspinstall and npm) but
  -- it can be set to false to disable.
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,
  -- Enable fish support (fish being a superset of bash)
  fish = false,
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
  local langs = { 'bash' }
  if L.config.fish then
    table.insert(langs, 'fish')
  end
  layers.get('treesitter').langs(langs)

  -- Enable the language server
  if L.config.lsp ~= false then
    layers
      .get('lsp')
      .use_server(
        'bash',
        L.config.lsp == nil,
        L.config.lsp or 'bashls',
        L.config.lspconfig
      )
  end
end

return L
