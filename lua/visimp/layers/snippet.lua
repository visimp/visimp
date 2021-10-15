local L = require('visimp.layer').new_layer('snippet')
local loader = require('visimp.loader')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module

L.default_config = {}

function L.dependencies()
  return {'cmp'}
end

function L.preload()
  package('l3mon4d3/luasnip')
  package('saadparwaiz1/cmp_luasnip')

  -- Configure the completion layer
  local cmp = loader.get('cmp')
  cmp.add_source({ name = 'luasnip' })
  cmp.set_snippet({
    expand = function(args)
      get_module('luasnip').lsp_expand(args.body)
    end,
  })
end

return L
