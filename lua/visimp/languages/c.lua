local L = require('visimp.layer'):new_layer 'c'
local layers = require 'visimp.loader'

L.default_config = {
  c = true,
  cpp = true,
  lspconfig = {},
}

---Declare LS usage
---@param language string The LS will be attached to buffers of this filetype
local function use_server(language)
  local install = L.config.lsp == nil
  local server = L.config.lsp or 'clangd'
  local settings = L.config.lspconfig
  local lsp = layers.get 'lsp' --[[@as LspLayer]]
  lsp:use_server(language, install, server, settings)
end

function L.preload()
  -- Configure Tree-sitter
  local langs = {}
  if L.config.c then
    table.insert(langs, 'c')
  end
  if L.config.cpp then
    table.insert(langs, 'cpp')
  end
  (layers.get 'treesitter' --[[@as TreesitterLayer]]):langs(langs)

  -- Enable the language server
  if L.config.lsp ~= false then
    if L.config.c then
      use_server 'c'
    end
    if L.config.cpp then
      use_server 'cpp'
    end
  end
end

return L
