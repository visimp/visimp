local L = require('visimp.layer').new_layer('latex')
local layers = require('visimp.loader')

L.default_config = {
  -- The lsp server to use. Defaults to nil(texlab via lspinstall) but users can 
  -- also specify another lspconfig server via a string. Set to false to disable.
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,
  -- Automatically compile latex via texlab LSP
  autocompile = true
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
  layers.get('treesitter').langs({'latex'})

  -- Enable the language server
  if L.config.lsp ~= false then
    layers.get('lsp').use_server('latex',
      L.config.lsp == nil, L.config.lsp or 'texlab', L.config.lspconfig)
    if L.config.autocompile then
      vim.cmd('autocmd BufWritePost *.tex :TexlabBuild')
    end
  end
end
return L
