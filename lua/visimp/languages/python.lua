local L = require('visimp.layer').new_layer('python')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil(clangd) but users can also use
  -- alternatives such as ccls. Can be set to false to disable this functionality
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil
}

function L.dependencies()
  local deps = {'treesitter'}
  if L.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.preload()
  -- Configure treesitter
  local ts = layers.get('treesitter')
  ts.langs({'python'})

  -- Enable the language server
  if L.config.lsp ~= false then
    local lsp = layers.get('lsp')
    lsp.use_server('python', L.config.lsp, L.config.lspconfig)
  end
end

return L
