local L = require('visimp.layer').new_layer 'hcl'
local layers = require 'visimp.loader'

L.default_config = {
  -- whether to use or disable the terraform lsp
  terraform = true,
  -- if the previous field is set to true, this object will be given to the LSP
  -- as configuration
  lspconfig = nil,
}

function L.dependencies()
  local deps = { 'treesitter' }
  if L.config.terraform ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.preload()
  -- Configure treesitter
  local langs = { 'hcl' }
  if L.config.terraform ~= false then
    table.insert(langs, 'terraform')
  end
  layers.get('treesitter').langs(langs)

  -- Enable the language server
  if L.config.terraform ~= false then
    layers.get('lsp').use_server(
      'terraform',
      L.config.lsp == nil,
      L.config.lsp or 'terraformls',
      L.config.lspconfig
    )
  end
end

return L
