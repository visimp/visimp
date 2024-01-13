local L = require('visimp.layer').new_layer 'lua'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use lua_ls LSP, otherwhise can specify local
  -- installation or disable by setting to false.
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
  layers.get('treesitter').langs { 'lua' }

  -- Enable the language server
  if L.config.lsp ~= false then
    layers
      .get('lsp')
      .use_server('lua', L.config.lsp == nil, L.config.lsp or 'lua_ls', L.config.lspconfig)
  end
end

return L
