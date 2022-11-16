local L = require('visimp.layer').new_layer('lsp')
local bind = require('visimp.bind').bind
local get_module = require('visimp.bridge').get_module

local border_opts = { border = 'single' }

L.servers = {}
L.callbacks = {}
L.capabilities = nil
L.use_nullls = false
L.default_config = {
  -- Can be set to false to disable installing all language servers
  install = true,
  mason = {},
  nullls = {},
  binds = {
    [{ mode = 'n', bind = 'gD', desc = 'Go to declaration' }] = vim.lsp.buf.declaration,
    [{ mode = 'n', bind = 'gd', desc = 'Go to definition' }] = vim.lsp.buf.definition,
    [{ mode = 'n', bind = 'K', desc = 'Show hover' }] = function()
      vim.lsp.buf.hover(border_opts)
    end,
    [{ mode = 'n', bind = 'gi', desc = 'Go to implementation' }] = vim.lsp.buf.implementation,
    [{ mode = 'n', bind = '<C-k>', desc = 'Show signature help' }] = function()
      vim.lsp.buf.signature_help(border_opts)
    end,
    [{ mode = 'n', bind = '<leader>D', desc = 'Show type definition' }] = vim.lsp.buf.type_definition,
    [{ mode = 'n', bind = '<leader>rn', desc = 'Rename the current symbol' }] = vim.lsp.buf.rename,
    [{ mode = 'n', bind = '<leader>ca', desc = 'Run a code action' }] = vim.lsp.buf.code_action,
    [{ mode = 'n', bind = 'gr', desc = 'Go to references' }] = vim.lsp.buf.references,
    [{ mode = 'n', bind = '<leader>e', desc = 'Show line diagnostics' }] = function()
      vim.diagnostic.open_float(border_opts)
    end,
    [{ mode = 'n', bind = '[d', desc = 'Go to previous diagnostic' }] = vim.diagnostic.goto_prev,
    [{ mode = 'n', bind = ']d', desc = 'Go to next diagnostic' }] = vim.diagnostic.goto_next,
    [{ mode = 'n', bind = 'gf', desc = 'Format the current buffer' }] = vim.lsp.buf.formatting,
  },
}

function L.packages()
  return {
    'neovim/nvim-lspconfig',
    { 'williamboman/mason.nvim', opt = true },
    { 'williamboman/mason-lspconfig.nvim', opt = true },
    -- TODO: should be optional as its required by null-ls, itself being an
    -- optional dependecy. This currently cannot be achieved as it'll break other
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
    vim.cmd('packadd mason.nvim')
    vim.cmd('packadd mason-lspconfig.nvim')
    get_module('mason').setup(L.config.mason or {})

    local required = {}
    for _, srv in ipairs(L.servers) do
      if srv.install and type(srv.server) == 'string' then
        table.insert(required, srv.server)
      end
    end
    get_module('mason-lspconfig').setup({
      ensure_installed = required,
    })
  end

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
    bind(L.config.binds, nil)

    for _, fn in ipairs(L.callbacks) do
      fn(...)
    end
  end

  for _, srv in ipairs(L.servers) do
    get_module('lspconfig')[srv.server].setup({
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
