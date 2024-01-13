local L = require('visimp.layer').new_layer 'vue'
local layers = require 'visimp.loader'

L.default_config = {
  -- Leave to nil to use the volar LSP, false to disable, a string (i.e.
  -- 'vuels') to use another lsp on your system
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
  layers.get('treesitter').langs { 'vue', 'css', 'javascript' }

  -- Enable the language server
  if L.config.lsp ~= false then
    local install = L.config.lsp == nil
    local server = L.config.lsp or 'volar'
    local settings = L.config.lspconfig
    layers.get('lsp').use_server('vue', install, server, settings)
  end
end

return L
