---@class LspLayer: Layer
local L = require('visimp.layer'):new_layer 'lsp'
local bind = require('visimp.bind').bind
local get_module = require('visimp.bridge').get_module

L.servers = {}
L.callbacks = {}
L.one_time_callbacks = {}
---The [set](https://www.lua.org/pil/11.5.html) of IDs of buffers that have had
---an LSP attached to them at least once. Closed buffers can also be in it.
L.buffers = {}
L.capabilities = nil
L.use_nullls = false
L.default_config = {
  ---Can be set to false to disable installing all language servers
  install = true,
  ---Can be set to nil to disable LSP progress reports
  progress = {},
  ---A valid mason.nvim configuration
  mason = {
    registries = {
      'github:mason-org/mason-registry',
      'github:visimp/mason-registry',
    },
  },
  ---A valid mason-tool-installer.nvim configuration
  mason_tool_installer = {},
  ---Strings used as keys are considered null-ls source names, and their values
  ---the respective configs. When non-strings are used as keys (e.g. implicit
  ---number indices in arrays), their values are assumed to be null-ls source
  ---names w/o configs.
  nullls = {},
  binds = {
    [{
      mode = 'n',
      bind = 'gD',
      opts = {
        desc = 'Go to declaration',
      },
    }] = vim.lsp.buf.declaration,
    [{
      mode = 'n',
      bind = 'gd',
      opts = {
        desc = 'Go to definition',
      },
    }] = vim.lsp.buf.definition,
    [{
      mode = 'n',
      bind = 'K',
      opts = {
        desc = 'Show hover',
      },
    }] = function()
      vim.lsp.buf.hover()
    end,
    [{
      mode = 'n',
      bind = 'gi',
      opts = {
        desc = 'Go to implementation',
      },
    }] = vim.lsp.buf.implementation,
    [{
      mode = 'n',
      bind = '<C-k>',
      opts = {
        desc = 'Show signature help',
      },
    }] = function()
      vim.lsp.buf.signature_help()
    end,
    [{
      mode = 'n',
      bind = '<leader>D',
      opts = {
        desc = 'Show type definition',
      },
    }] = vim.lsp.buf.type_definition,
    [{
      mode = 'n',
      bind = '<leader>rn',
      opts = {
        desc = 'Rename the current symbol',
      },
    }] = vim.lsp.buf.rename,
    [{
      mode = 'n',
      bind = '<leader>ca',
      opts = {
        desc = 'Run a code action',
      },
    }] = vim.lsp.buf.code_action,
    [{
      mode = 'n',
      bind = 'gr',
      opts = {
        desc = 'Go to references',
      },
    }] = vim.lsp.buf.references,
    [{
      mode = 'n',
      bind = '<leader>e',
      opts = {
        desc = 'Show line diagnostics',
      },
    }] = function()
      vim.diagnostic.open_float()
    end,
    [{
      mode = 'n',
      bind = '[d',
      opts = {
        desc = 'Go to previous diagnostic',
      },
    }] = function()
      vim.diagnostic.jump { count = 1, float = true }
    end,
    [{
      mode = 'n',
      bind = ']d',
      opts = {
        desc = 'Go to next diagnostic',
      },
    }] = function()
      vim.diagnostic.jump { count = 1, float = true }
    end,
    [{
      mode = 'n',
      bind = 'gf',
      opts = {
        desc = 'Format the current buffer',
      },
    }] = vim.lsp.buf.formatting,
  },
}

function L:packages()
  return {
    'neovim/nvim-lspconfig',
    { 'williamboman/mason.nvim', opt = true },
    { 'williamboman/mason-lspconfig.nvim', opt = true },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', opt = true },
    -- TODO: should be optional as its required by null-ls, itself being an
    -- optional dependency. This currently cannot be achieved as it'll break
    -- other packages which have a hard dependency on plenary. This fix belongs
    -- to the package manager dependency resolution.
    'nvim-lua/plenary.nvim',
    { 'nvimtools/none-ls.nvim', opt = true },
    -- TODO: remove `branch: 'legacy'` once fidget.nvim has been rewritten
    { 'j-hui/fidget.nvim', opt = true, branch = 'legacy' },
  }
end

function L:preload()
  if next(self.config.nullls) then
    self.use_nullls = true
  end
end

---Adds a new null-ls source.
---@param sources string[] Sources list
---@param new_source_name string Name for the new source
---@param config table|nil Optional config for the new source
local function add_source(sources, new_source_name, config)
  local module =
    get_module(string.format('null-ls.builtins.%s', new_source_name))
  if config then
    module = module.with(config)
  end
  table.insert(sources, module)
end

function L:load()
  if self.config.install then
    vim.cmd 'packadd mason.nvim'
    vim.cmd 'packadd mason-lspconfig.nvim'
    vim.cmd 'packadd mason-tool-installer.nvim'
    get_module('mason').setup(self.config.mason or {})
    get_module('mason-lspconfig').setup { automatic_enable = false }

    local required = {}
    for _, srv in ipairs(self.servers) do
      if srv.install and type(srv.server) == 'string' then
        table.insert(required, srv.server)
      end
    end
    get_module('mason-tool-installer').setup(
      vim.tbl_deep_extend(
        'force',
        { ensure_installed = required },
        self.config.mason_tool_installer
      )
    )
  end

  if self.config.progress ~= nil then
    vim.cmd 'packadd fidget.nvim'
    get_module('fidget').setup()
  end

  -- null-ls sources
  local sources = {}
  if self.use_nullls then
    vim.cmd 'packadd none-ls.nvim'
    for k, v in pairs(self.config.nullls) do
      -- source config is specified
      if type(k) == 'string' then
        add_source(sources, k, v)
      else
        -- source config is not specified
        add_source(sources, v)
      end
    end
  end

  local on_attach = function(client, bufnr, ...)
    if not self.buffers[bufnr] then
      -- Enable module binds first so they can be overwritten by other
      -- callbacks if needed
      bind(self.config.binds, nil, bufnr)
      for _, fn in ipairs(self.one_time_callbacks) do
        fn(client, bufnr, ...)
      end

      self.buffers[bufnr] = true
    end

    for _, fn in ipairs(self.callbacks) do
      fn(client, bufnr, ...)
    end
  end

  for _, srv in ipairs(self.servers) do
    get_module('lspconfig')[srv.server].setup {
      settings = srv.settings,
      capabilities = self.capabilities,
      on_attach = on_attach,
    }
  end
  if self.use_nullls then
    get_module('null-ls').setup {
      sources = sources,
      capabilities = self.capabilities,
      on_attach = on_attach,
    }
  end
end

---Enables an LSP server at startup
---@param lang string The name of the language (used by Mason)
---@param install boolean True if the server should be installed via Mason
---@param srv string The name of the server executable (if any)
---@param settings table|nil Any optional settings for the language server
function L:use_server(lang, install, srv, settings)
  table.insert(self.servers, {
    language = lang,
    install = install,
    server = srv,
    settings = settings,
  })
end

---Adds an on_attach function which gets called when LSPs get enabled on
---buffers
---@param fn function The callback function
function L:on_attach(fn)
  table.insert(self.callbacks, fn)
end

---Adds a one-time on_attach function which gets called the first time a LS is
---enabled on each buffer
---@param fn function The callback function
function L:on_attach_one_time(fn)
  table.insert(self.one_time_callbacks, fn)
end

---Returns the list of on_attach callbacks
---@return function[] callbacks A list of callbacks
function L:get_callbacks()
  return self.callbacks
end

---Returns the list of one-time on_attach callbacks
---@return function[] callbacks A list of callbacks
function L:get_callbacks_one_time()
  return self.one_time_callbacks
end

---Sets the capabilities table
---@param fn function The hook
function L:on_capabilities(fn)
  self.capabilities = fn
end

---Returns the current capabilities handler
---@return function capabilities The capabilities handler
function L:get_capabilities()
  return self.capabilities
end

return L
