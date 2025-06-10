---@class CmpLayer : Layer
local L = require('visimp.layer'):new_layer 'cmp'
local loader = require 'visimp.loader'
local get_module = require('visimp.bridge').get_module

L.sources = {}
L.snippet = {}
L.default_config = {
  ---Autocomplete from the buffer
  buffer = false,
  ---Autocomplete from lsp suggestions
  lsp = true,
  -- Lsp symbols a la IntelliSense
  lspkind = true,
  --Completion mappings
  mapping = {
    ['<C-d>'] = function(cmp)
      return cmp.mapping.scroll_docs(-4)
    end,
    ['<C-f>'] = function(cmp)
      return cmp.mapping.scroll_docs(4)
    end,
    ['<C-Space>'] = function(cmp)
      return cmp.mapping.complete()
    end,
    ['<C-e>'] = function(cmp)
      return cmp.mapping.close()
    end,
    ['<CR>'] = function(cmp)
      return cmp.mapping.confirm {
        behaviour = cmp.ConfirmBehavior.Replace,
        select = true,
      }
    end,
    -- Could be overwritten by other plugins such as snippet managers
    ['<Tab>'] = function(cmp)
      return cmp.mapping.select_next_item()
    end,
    ['<S-Tab>'] = function(cmp)
      return cmp.mapping.select_prev_item()
    end,
  },

  ---Broader and general nvim cmp configuration
  config = {
    experimental = {
      ghost_text = true,
    },
  },

  lspkindconfig = {
    with_text = false,
    max_width = 65,
  },
}

function L:packages()
  return {
    'hrsh7th/nvim-cmp',
    { 'hrsh7th/cmp-buffer', opt = true },
    { 'hrsh7th/cmp-nvim-lsp', opt = true },
    { 'onsails/lspkind-nvim', opt = true },
  }
end

function L:dependencies()
  if self.config.lsp then
    return { 'lsp' }
  end
  return {}
end

function L:preload()
  -- load optional packages
  if L.config.buffer then
    vim.cmd 'packadd cmp-buffer'
  end

  if L.config.lspkind then
    vim.cmd 'packadd lspkind-nvim'
  end

  if L.config.lsp then
    vim.cmd 'packadd cmp-nvim-lsp';
    (loader.get 'lsp' --[[@as LspLayer]]):on_capabilities(
      get_module('cmp_nvim_lsp').default_capabilities()
    )
  end
end

function L:load()
  local cmp = get_module 'cmp'
  local cfg = vim.tbl_deep_extend(
    'force',
    self.config.config,
    { sources = L.sources, snippet = self.snippet }
  )
  if self.config.buffer then
    table.insert(cfg.sources, { name = 'buffer' })
  end
  if self.config.lsp then
    table.insert(cfg.sources, { name = 'nvim_lsp' })
  end
  if self.config.lspkind then
    local lspkind = get_module 'lspkind'
    cfg.formatting = {
      format = lspkind.cmp_format(self.config.lspkindconfig),
    }
  end
  cfg.mapping = vim.tbl_map(function(f)
    return f(cmp)
  end, self.config.mapping)

  cmp.setup(cfg)
end

---Adds a completion source object
---@param source table The source completion object
function L:add_source(source)
  table.insert(self.sources, source)
end

---Sets the completion snippet handler
---@param snippet table The snippet object
function L:set_snippet(snippet)
  self.snippet = snippet
end

return L
