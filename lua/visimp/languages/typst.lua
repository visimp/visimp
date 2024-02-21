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
  -- Optional configuration to be provided for typst.vim, as described in
  -- https://github.com/kaarmu/typst.vim?tab=readme-ov-file#options. Keys are
  -- specified without the 'typst_' prefix
  pluginconfig = {
    -- auto_close_toc = 1 -- whether automatically close TOC (default: 0)
  },
}

function L.packages()
  return { 'kaarmu/typst.vim' }
end

function L.dependencies()
  local deps = { 'treesitter' }
  if L.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

function L.preload()
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

--- typst.vim setup
--- @param config table See
--    https://github.com/kaarmu/typst.vim?tab=readme-ov-file#options. Keys are
--    specified without the 'typst_' prefix.
local function plugin_setup(config)
  for setting, value in pairs(config) do
    vim.g['typst_' .. setting] = value
  end
end

function L.load()
  -- Additional plugin
  vim.cmd 'packadd typst.vim'
  local pluginconfig = L.config.pluginconfig
  if type(pluginconfig) == 'table' then
    plugin_setup(pluginconfig)
  end
end

return L
