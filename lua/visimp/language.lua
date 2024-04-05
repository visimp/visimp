local new_layer = require('visimp.layer').new_layer
local layers = require 'visimp.loader'

--- Utilities for constructing and identifying layers
-- @module visimp.language
local M = {}

--- Default implementation for "dependencies" method of language layers
--- @param l table Language layer
--- @return table dependencies List of dependencies
local function language_layer_dependencies(l)
  local deps = { 'treesitter' }
  if l.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

--- Adds new filetypes mappings
--- @param filetypes table Filetypes mappings as described in
-- https://neovim.io/doc/user/lua.html#vim.filetype.add()
local function add_filetypes(filetypes)
  vim.filetype.add(filetypes)
end

--- Adds the specified languages to Treesitter
--- @param grammars table Array of Treesitter grammar names
local function add_grammars(grammars)
  layers.get('treesitter').langs(grammars)
end

--- Adds the appropriate language server based on the language layer
---@param l table Language layer
local function add_server(l)
  local server = l.server()
  if server and l.config.lsp ~= false then
    layers.get('lsp').use_server(
      l.identifier,
      l.config.lsp == nil,
      l.config.lsp or server,
      l.config.lspconfig
    )
  end
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

  function l.filetypes()
    return {}
  end

  function l.grammars()
    return {}
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
