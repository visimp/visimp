local L = require('visimp.layer').new_layer('python')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil(pyright via lspinstall & npm) but
  -- users can also use alternatives such as 'pyright' for a local installation.
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
  layers.get('treesitter').langs({'python'})

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server('python',
      L.config.lsp == nil, L.config.lsp or 'pyright', L.config.lspconfig)
  end
end

return L
