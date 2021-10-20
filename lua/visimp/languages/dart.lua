local L = require('visimp.layer').new_layer('dart')
local layers = require('visimp.loader')
local get_module = require('visimp.utils').get_module

L.default_config = {
  -- Uses systems' `dartls` by default, but can be disabled by setting to false
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,
  -- Can be set to false to disable the integration with the Flutter framework
  flutter = true,
  -- Flutter tools configuration
  flutterconfig = {}
}

function L.dependencies()
  local deps = {'treesitter'}
  if L.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.packages()
  return {
    {'nvim-lua/plenary.nvim', opt=true},
    {'akinsho/flutter-tools.nvim', opt=true}
  }
end

function L.preload()
  -- Configure treesitter
  layers.get('treesitter').langs({'dart'})

  if L.config.flutter then
    vim.cmd('packadd flutter-tools.nvim')
  end

  -- Enable the language server
  if L.config.lsp ~= false and not L.config.flutter then
    layers.get('lsp').use_server('dart', false, 'dartls', L.config.lspconfig)
  end
end

function L.load()
  if L.config.flutter then
    get_module('flutter-tools').setup(L.config.flutterconfig or {})
  end
end

return L
