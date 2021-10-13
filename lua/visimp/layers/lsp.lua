local L = require('visimp.layer').new_layer('lsp')
local package = require('visimp.pak').register
local utils = require('visimp.utils')
local bind = require('visimp.bind').bind
local contains, get_module = utils.contains, utils.get_module

L.servers = {}
L.callbacks = {}
L.capabilities = nil
L.default_config = {
  -- Can be set to false to disable installing all language servers
  install = true,
  binds = {
    ['buf.declaration'] = { mode = 'n', bind = 'gD' },
    ['buf.definition'] = { mode = 'n', bind = 'gd' },
    ['buf.hover'] = { mode = 'n', bind = 'K' },
    ['buf.implementation'] = { mode = 'n', bind = 'gi' },
    ['buf.signature_help'] = { mode = 'n', bind = '<C-k>' },
    ['buf.type_definition'] = { mode = 'n', bind = '<leader>D' },
    ['buf.rename'] = { mode = 'n', bind = '<leader>rn' },
    ['buf.code_action'] = { mode = 'n', bind = '<leader>ca' },
    ['buf.references'] = { mode = 'n', bind = 'gr' },
    ['diagnostic.show_line_diagnostics'] = { mode = 'n', bind = '<leader>e' },
    ['diagnostic.goto_prev'] = { mode = 'n', bind = '[d' },
    ['diagnostic.goto_next'] = { mode = 'n', bind = ']d' },
    ['buf.formatting'] = { mode = 'n', bind = '<leader>f' }
  }
}

function L.preload()
  package('neovim/nvim-lspconfig')
  if L.config.install then
    package('kabouzeid/nvim-lspinstall')
  end
end

function L.load()
  vim.cmd('packadd nvim-lspconfig')

  local lsp = get_module('lspconfig')
  if L.config.install then
    local ins = get_module('lspinstall')

    for _, srv in ipairs(L.servers) do
      if srv.server == nil then -- nil means default auto install
        if not ins.is_server_installed(srv.language) then
          ins.install_server(srv.language)
        end
      end
    end

    -- If we are using lsp install let it change nvim lspconfig default 
    -- configurations. 
    ins.setup()
  end

  for _, srv in ipairs(L.servers) do
    local name = srv.server == nil and srv.language or srv.server
    lsp[name].setup{
      settings = srv.settings,
      capabilities = L.capabilities,
      on_attach = function(...)
        -- Enable module binds first so they can be overwritten by other
        -- callbacks if needed
        bind(L.config.binds, function (key)
          local scope = vim.lsp
          for str in string.gmatch(key, '([^.]+)') do
            scope = scope[str]
          end
          return scope
        end)

        for _, fn in ipairs(L.callbacks) do
          fn(...)
        end
      end,
    }
  end
end

--- Enables an LSP server at startup
-- @param lang The name of the language (used by lspinstall)
-- @param srv The name of the server executable (if any)
-- @param settings Any optional settings for the language server
function L.use_server(lang, srv, settings)
  table.insert(L.servers, {
    language = lang,
    server = srv,
    settings = settings
  })
end

--- Adds an on_attach function which gets called when LSPs get enabled on buffers
-- @param fn The callback function
function L.on_attach(fn)
  table.insert(L.callbacks, fn)
end

--- Sets the capabilities table
-- @param fn The hook
function L.on_capabilities(fn)
  L.capabilities = fn
end

return L
