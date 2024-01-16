local L = require('visimp.layer').new_layer 'csharp'
local layers = require 'visimp.loader'

L.default_config = {
  -- The lsp server to use. Defaults to omnisharp but users can also provide
  -- their local executables or disable the functionality by settings this to
  -- false.
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
  layers.get('treesitter').langs { 'c_sharp' }

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server(
      'csharp',
      L.config.lsp == nil,
      L.config.lsp or 'omnisharp',
      L.config.lspconfig
    )
  end
end

return L
