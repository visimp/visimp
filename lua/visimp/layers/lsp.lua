local L = require('visimp.layer').new_layer('lsp')
local bind = require('visimp.bind').bind
local get_module = require('visimp.utils').get_module

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
    ['buf.formatting'] = { mode = 'n', bind = '<leader>f' },
  },
}

function L.packages()
  return {
    'neovim/nvim-lspconfig',
    { 'williamboman/nvim-lsp-installer', opt = true },
  }
end

function L.load()
  if L.config.install then
    vim.cmd('packadd nvim-lsp-installer')
    local has = get_module('nvim-lsp-installer.servers').is_server_installed
    local install = get_module('nvim-lsp-installer').install

    for _, srv in ipairs(L.servers) do
      if srv.install and type(srv.server) == 'string' then
        if not has(srv.server) then
          install(srv.server)
        end
      end
    end
  end

  -- TODO: customizable and generalized
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'single' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'single' }
  )

  for _, srv in ipairs(L.servers) do
    local server
    if L.config.install and srv.install then
      _, server = get_module('nvim-lsp-installer.servers').get_server(
        srv.server
      )
    else
      server = get_module('lspconfig')[srv.server]
    end
    server:setup({
      settings = srv.settings,
      capabilities = L.capabilities,
      on_attach = function(...)
        -- Enable module binds first so they can be overwritten by other
        -- callbacks if needed
        bind(L.config.binds, function(key)
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
    })
  end
end

--- Enables an LSP server at startup
-- @param lang The name of the language (used by lspinstall)
-- @param install True if the server should be installed via lspinstall
-- @param srv The name of the server executable (if any)
-- @param settings Any optional settings for the language server
function L.use_server(lang, install, srv, settings)
  table.insert(L.servers, {
    language = lang,
    install = install,
    server = srv,
    settings = settings,
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
