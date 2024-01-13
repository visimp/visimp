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
    local install = L.config.lsp == nil
    local server = L.config.lsp or 'clangd'
    local settings = L.config.lspconfig
    layers.get('lsp').use_server('lua', install, server, settings)
  end
end

return L
