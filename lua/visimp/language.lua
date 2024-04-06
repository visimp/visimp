local new_layer = require('visimp.layer').new_layer
local layers = require 'visimp.loader'

--- Utilities for constructing and identifying layers
-- @module visimp.language
local M = {}

---Checks if a given table is empty or not
---@param t table The table to inspect
---@return boolean Result True if t is has no values in it, false otherwise
local function is_empty(t)
  return next(t) == nil
end

--- Default implementation for "dependencies" method of language layers
--- @param l table Language layer
--- @return table dependencies List of dependencies
local function language_layer_dependencies(l)
  local deps
  -- treesitter
  local grammars = l.grammars()
  if type(grammars) ~= 'table' or is_empty(grammars) then
    deps = {}
  else
    deps = { 'treesitter' }
  end
  -- lsp
  if l.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

--- Adds new filetypes mappings
--- @param filetypes table Filetypes mappings as described in
-- https://neovim.io/doc/user/lua.html#vim.filetype.add()
local function add_filetypes(filetypes)
  if filetypes then
    vim.filetype.add(filetypes)
  end
end

--- Adds the specified languages to Treesitter
--- @param grammars table Array of Treesitter grammar names
local function add_grammars(grammars)
  if not grammars then
    return
  end
  local t = type(grammars)
  if t ~= 'table' then
    error('Grammars should be string array. Got ' .. t)
  end
  layers.get('treesitter').langs(grammars)
end

--- Adds the appropriate language server based on the language layer
---@param l table Language layer
local function add_server(l)
  if l.config.lsp == false then
    return
  end
  local server = l.server()
  if not server then
    server = l.config.lsp
  end
  local t = type(server)
  if t ~= 'string' then
    error('Server name should be string. Got ' .. t)
  end
  layers.get('lsp').use_server(
    l.identifier,
    l.config.lsp == nil,
    server,
    l.config.lspconfig
  )
end

---Default implementation for "preload" method of language layers
--- @param l table Language layer
local function language_layer_preload(l)
  add_filetypes(l.filetypes())
  add_grammars(l.grammars())
  add_server(l)
end

--- Returns an new language layer for the given identifier
-- @param id The layer identifier
-- @return The newly created layer
function M.new_language(id)
  local l = new_layer(id)

  l.default_config = {
    -- The LSP server to use. Defaults to nil (recommended LS) but users can
    -- also use alternatives. Can be set to false to disable this functionality
    lsp = nil,
    -- Optional configuration to be provided for the chosen language server
    lspconfig = nil,
  }

  function l.filetypes()
    return nil
  end

  function l.grammars()
    return nil
  end

  function l.server()
    return nil
  end

  function l.dependencies()
    return language_layer_dependencies(l)
  end

  function l.preload()
    language_layer_preload(l)
  end

  return l
end

return M
