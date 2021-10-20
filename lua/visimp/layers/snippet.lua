local L = require('visimp.layer').new_layer('snippet')
local loader = require('visimp.loader')
local get_module = require('visimp.utils').get_module

L.default_config = {}

function L.dependencies()
  return {'cmp'}
end

function L.packages()
  return {
    'l3mon4d3/luasnip',
    'saadparwaiz1/cmp_luasnip'
  }
end

-- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function L.preload()
  local tab = loader.get('cmp').config.mapping['<Tab>']
  local stab = loader.get('cmp').config.mapping['<S-Tab>']
  loader.get('cmp').config.mapping['<S-Tab>'] = function(cmp)
    return cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        get_module('luasnip').expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        (tab ~= nil and tab or fallback)()
      end
    end, { "i", "s" })
  end
end

function L.load()
  -- Configure the completion layer
  local cmp = loader.get('cmp')
  cmp.add_source({ name = 'luasnip' })
  cmp.set_snippet({
    expand = function(args)
      get_module('luasnip').lsp_expand(args.body)
    end,
  })
  get_module('luasnip').setup(L.config or {})
end

return L
