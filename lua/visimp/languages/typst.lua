local L = require('visimp.layer').new_layer 'typst'
local get_layer = require('visimp.loader').get

L.default_config = {
  -- Leave to nil to use typst-lsp, false to disable, a string to use a
  -- local binary
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = {
    exportPdf = 'onType',
  },
}

local function add_filetype()
  vim.filetype.add {
    extension = {
      typ = 'typst',
    },
  }
end

function L.dependencies()
  local deps = { 'treesitter' }
  if L.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.preload()
  add_filetype()

  -- Configure treesitter
  get_layer('treesitter').langs { 'typst' }

  -- Enable the language server
  if L.config.lsp ~= false then
    local install = L.config.lsp == nil
    local server = L.config.lsp or 'typst_lsp'
    local settings = L.config.lspconfig
    get_layer('lsp').use_server('typst', install, server, settings)
  end
end

return L
