local L = require('visimp.layer').new_layer 'lspformat'
local get_module = require('visimp.bridge').get_module
local get_layer = require('visimp.loader').get

L.default_config = {
  -- Applies an autocommand to fix the behaviours when quitting and wiring.
  -- Because the formatter is async by default the code wouldn't be patched
  -- without this fix when wiring and closing the editor at the same time.
  wq_fix = true,
}

function L.dependencies()
  return { 'lsp' }
end

function L.packages()
  return { 'lukas-reineke/lsp-format.nvim' }
end

function L.preload()
  get_layer('lsp').on_attach(get_module('lsp-format').on_attach)
end

function L.load()
  if L.config.wq_fix then
    -- Taken from
    -- https://github.com/lukas-reineke/lsp-format.nvim#wq-will-not-format
    vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
  end

  get_module('lsp-format').setup(L.config or {})
end

return L
