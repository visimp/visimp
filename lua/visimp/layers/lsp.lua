local L = require('visimp.layer').new_layer('lsp')
local package = require('visimp.pak').register

local function get_lsp()
  local ok, lsp = pcall(require, 'lspconfig')
  if not ok then
    error('Neovim LSP not installed:\n' .. lsp)
  end
  return lsp
end

L.default_config = {
  -- can be either an array listing all lsp excluded from auto-installation
  -- or a boolean to disable or enable the feature entirely
  skip_install = false
}

function L.preload()
  package('neovim/nvim-lspconfig')
  if not L.config.skip_install then
    package('kabouzeid/nvim-lspinstall')
  end

  -- load the needed vimscript section of nvim lsp
  vim.cmd('packadd nvim-lspconfig')
end

function L.load()
  local lsp = get_lsp()
end

return L
