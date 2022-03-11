local L = require('visimp.layer').new_layer('lspsaga')
local loader = require('visimp.loader')
local get_module = require('visimp.bridge').get_module
local bind = require('visimp.bind').bind

L.default_config = {
  -- LSPSaga configuration
  config = {},
  binds = {
    [{ mode = 'n', bind = 'gh' }]         = [{ 'provider', 'lsp_finder' }],
    [{ mode = 'n', bind = '<leader>ca' }] = [{ 'codeaction', 'code_action' }],
    [{ mode = 'n', bind = 'K' }]          = [{ 'hover', 'render_hover_doc' }],
    [{ mode = 'n', bind = 'gr' }]         = [{ 'rename', 'rename' }]
  },
}

function L.packages()
  -- main repository is unmaintained
  return { 'tami5/lspsaga.nvim' }
end

function L.dependecies()
  return { 'lsp' }
end

function L.load()
  get_module('lspsaga').init_lsp_saga(L.config.config or {})
  loader.get('lsp').on_attach(function()
    bind(L.config.binds, function(key)
      if type(key) ~= 'table' and #key ~= 2 then
        error(
          'Invalid bind key for lsp saga: use format {\'submodule\', \'fn\'})'
        )
      end
      return get_module('lspsaga.' .. key[1])[key[2]]
    end)
  end)
end

return L
