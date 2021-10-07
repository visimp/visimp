local L = require('visimp.layer').new_layer('cmp')
local loader = require('visimp.loader')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

L.default_config = {
  -- Autocopmlete from the buffer
  buffer = true,
  -- Autocomplete from lsp suggestions
  lsp = true,
  mapping = {
    ['<C-d>'] = function(cmp) cmp.mapping.scroll_docs(-4) end,
    ['<C-f>'] = function(cmp) cmp.mapping.scroll_docs(4) end,
    ['<C-Space>'] = function(cmp) cmp.mapping.complete() end,
    ['<C-e>'] = function(cmp) cmp.mapping.close() end,
    ['<CR>'] = function(cmp) cmp.mapping.confirm({ select = true }) end
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

  vim.cmd('packadd nvim-cmp')
end

function L.load()
  local cmp = get_module('cmp')
  local sources = {}
  if L.config.buffer then
    table.insert(sources, { name = 'buffer' })
  end
  if L.config.lsp then
    table.insert(sources, { name = 'nvim_lsp' })
  end

  cmp.setup({
    mapping = vim.tbl_map(function(f) return f(cmp) end, L.config.mapping),
    sources = sources
  })
  if L.config.lsp then
    loader.get('lsp').on_capabilities(
      get_module('cmp_nvim_lsp')
        .update_capabilities(vim.lsp.protocol.make_client_capabilities())
    )
  end
end

return L
