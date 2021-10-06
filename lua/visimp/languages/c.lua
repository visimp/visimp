local L = require('visimp.layer').new_layer('c')
local layers = require('visimp.loader')

L.default_config = {
  c = true,
  cpp = true,
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
  local langs = {}
  if L.config.c then
    table.insert(langs, 'c')
  end
  if L.config.cpp then
    table.insert(langs, 'cpp')
  end
  ts.langs(langs)

  -- Enable the language server
  if L.config.lsp ~= false then
    local lsp = layers.get('lsp')
    -- NOTE: nvim-lspinstall uses cpp to install clangd (which is the default)
    lsp.use_server('cpp', L.config.lsp, L.config.lspconfig)
  end
end

return L
