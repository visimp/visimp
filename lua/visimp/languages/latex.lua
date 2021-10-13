local L = require('visimp.layer').new_layer('latex')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil(texlab via lspinstall) but users can 
  -- also specify another lspconfig server via a string. Set to false to disable.
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
  ts.langs({'latex'})

  -- Enable the language server
  if L.config.lsp ~= false then
    local lsp = layers.get('lsp')
    lsp.use_server('latex', L.config.lsp, L.config.lspconfig)
  end
end
return L
