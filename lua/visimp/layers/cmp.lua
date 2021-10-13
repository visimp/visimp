local L = require('visimp.layer').new_layer('cmp')
local loader = require('visimp.loader')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

L.default_config = {
  -- Autocopmlete from the buffer
  buffer = false,
  -- Autocomplete from lsp suggestions
  lsp = true,
  lspkind = true,
  mapping = {
    ['<C-d>'] = function(cmp) return cmp.mapping.scroll_docs(-4) end,
    ['<C-f>'] = function(cmp) return cmp.mapping.scroll_docs(4) end,
    ['<C-Space>'] = function(cmp) return cmp.mapping.complete() end,
    ['<C-e>'] = function(cmp) return cmp.mapping.close() end,
    ['<CR>'] = function(cmp) return cmp.mapping.confirm({ select = true }) end
  }
}

function L.dependencies()
  if L.config.lsp then
    return {'lsp'}
  end
  return {}
end

function L.preload()
  package('hrsh7th/nvim-cmp')

  if L.config.buffer then
    package('hrsh7th/cmp-buffer')
  end
  if L.config.lsp then
    package('hrsh7th/cmp-nvim-lsp')
  end
  if L.config.lspkind then
    package('onsails/lspkind-nvim')
  end
end

function L.load()
  vim.cmd('packadd nvim-cmp')

  local cfg = { sources = {} }
  local cmp = get_module('cmp')
  -- TODO: understand why after/plugin/* files are not called with
  -- packadd and instead we need to register completion sources manually
  if L.config.buffer then
    cmp.register_source('buffer', get_module('cmp_buffer').new())
    table.insert(cfg.sources, { name = 'buffer' })
  end
  if L.config.lsp then
    local mod = get_module('cmp_nvim_lsp')
    mod.setup()
    table.insert(cfg.sources, { name = 'nvim_lsp' })
    loader.get('lsp').on_capabilities(
      mod.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    )
  end
  if L.config.lspkind then
    local lspkind = get_module('lspkind')
    cfg.formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
  end
  cfg.mapping = vim.tbl_map(function (f) return f(cmp) end, L.config.mapping)

  cmp.setup(cfg)
end

return L
