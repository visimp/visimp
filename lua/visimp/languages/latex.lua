local L = require('visimp.language').new_language 'latex'
local layers = require 'visimp.loader'

L.default_config = {
  ---Automatically compile latex via texlab LSP
  autocompile = true,
  ---Sets the latex compiler to tectonic
  tectonic = false,
}

function L.preload()
  -- Configure treesitter
  layers.get('treesitter').langs { 'latex' }

  -- Enable the language server
  local cfg = {}
  if L.config.autocompile then
    cfg = vim.tbl_deep_extend('force', cfg, {
      texlab = {
        build = { onSave = true },
      },
    })
  end
  if L.config.tectonic then
    cfg = vim.tbl_deep_extend('force', cfg, {
      texlab = {
        build = {
          executable = 'tectonic',
          args = { '%f', '--synctex', '--keep-logs', '--keep-intermediates' },
        },
      },
    })
  end
  cfg = vim.tbl_deep_extend('force', cfg, L.config.lspconfig or {})
  if L.config.lsp ~= false then
    local install = L.config.lsp == nil
    local server = L.config.lsp or 'texlab'
    layers.get('lsp').use_server('latex', install, server, cfg)
  end
end

return L
