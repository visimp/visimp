local L = require('visimp.layer').new_layer('lsp')
local bind = require('visimp.bind').bind
local get_module = require('visimp.bridge').get_module

L.servers = {}
L.callbacks = {}
L.capabilities = nil
L.use_nullls = false
L.default_config = {
  -- Can be set to false to disable installing all language servers
  install = true,
  nullls = {},
  binds = {
    [{ mode = 'n', bind = 'gD' }] = 'buf.declaration',
    [{ mode = 'n', bind = 'gd' }] = 'buf.definition',
    [{ mode = 'n', bind = 'K' }] = 'buf.hover',
    [{ mode = 'n', bind = 'gi' }] = 'buf.implementation',
    [{ mode = 'n', bind = '<C-k>' }] = 'buf.signature_help',
    [{ mode = 'n', bind = '<leader>D' }] = 'buf.type_definition',
    [{ mode = 'n', bind = '<leader>rn' }] = 'buf.rename',
    [{ mode = 'n', bind = '<leader>ca' }] = 'buf.code_action',
    [{ mode = 'n', bind = 'gr' }] = 'buf.references',
    [{ mode = 'n', bind = '<leader>e' }] = 'diagnostic.show_line_diagnostics',
    [{ mode = 'n', bind = '[d' }] = 'diagnostic.goto_prev',
    [{ mode = 'n', bind = ']d' }] = 'diagnostic.goto_next',
    [{ mode = 'n', bind = 'gf' }] = 'buf.formatting',
  },
}

function L.packages()
  return {
    'neovim/nvim-lspconfig',
    { 'williamboman/nvim-lsp-installer', opt = true },
    -- TODO: should be optional as its required by null-ls, itself being an
    -- optional dependecy. This currently cannot be cahieved as it'll break other
    -- packages which have a hard dependency on plenary. This fix belongs to
    -- the package manager dependency resolution.
    'nvim-lua/plenary.nvim',
    { 'jose-elias-alvarez/null-ls.nvim', opt = true },
  }
end

function L.preload()
  if table.getn(L.config.nullls) then
    L.use_nullls = true
  end
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

  -- null-ls sources
  local sources = {}
  if L.use_nullls then
    vim.cmd('packadd null-ls.nvim')
    for _, mod in ipairs(L.config.nullls) do
      table.insert(
        sources,
        get_module(string.format('null-ls.builtins.%s', mod))
      )
    end
  end

  local on_attach = function(...)
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
  end

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
      on_attach = on_attach,
    })
  end
  if L.use_nullls then
    get_module('null-ls').setup({
      sources = sources,
      capabilities = L.capabilities,
      on_attach = on_attach,
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

--- Returns the list of on_attach callbacks
-- @returns A list of callbacks
function L.get_callbacks()
  return L.callbacks
end

--- Sets the capabilities table
-- @param fn The hook
function L.on_capabilities(fn)
  L.capabilities = fn
end

--- Returns the current capabilities handler
-- @returns The capabilities handler
function L.get_capabilities()
  return L.capabilities
end

return L
