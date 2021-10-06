local L = require('visimp.layer').new_layer('lsp')
local package = require('visimp.pak').register
local contains = require('visimp.utils').contains

local function get_lsp(pkg)
  local ok, lsp = pcall(require, 'lspconfig')
  if not ok then
    error('Neovim LSP not installed:\n' .. lsp)
  end
  return lsp
end

local function get_lspinstall(pkg)
  local ok, lsp = pcall(require, 'lspinstall')
  if not ok then
    error('Neovim LSP install not installed:\n' .. lsp)
  end
  return lsp
end

L.servers = {}
L.default_config = {
  -- Can be set to false to disable installing all language servers
  install = true
}

function L.preload()
  package('neovim/nvim-lspconfig')
  if L.config.install then
    package('kabouzeid/nvim-lspinstall')
  end

  -- Load the needed vimscript section of nvim lsp
  vim.cmd('packadd nvim-lspconfig')
end

function L.load()
  local lsp = get_lsp()
  if L.config.install then
    local ins = get_lspinstall()

    for _, srv in ipairs(L.servers) do
      if srv.server == nil then -- nil means default auto install
        if not ins.is_server_installed(srv.language) then
          ins.install_server(srv.language)
        end
      end
    end

    -- If we are using lsp install let it change nvim lspconfig default 
    -- configurations. 
    get_lspinstall().setup()
  end

  for _, srv in ipairs(L.servers) do
    local name = srv.server == nil and srv.language or srv.server
    lsp[name].setup{
      settings = srv.settings,
      on_attach = function()
        print('attached')
      end
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

return L
