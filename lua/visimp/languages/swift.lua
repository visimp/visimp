local L = require('visimp.layer').new_layer 'swift'
local layers = require 'visimp.loader'

L.default_config = {
  -- The lsp server to use. Defaults to nil(sourcekit lsp already available on
  -- the system) but users can also specify another server executable via a
  -- string. Set to false to disable.
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
  layers.get('treesitter').langs { 'swift' }

  -- Enable the language server
  if L.config.lsp ~= false then
    layers
      .get('lsp')
      .use_server('swift', false, L.config.lsp or 'sourcekit', L.config.lspconfig)
  end
end

return L
