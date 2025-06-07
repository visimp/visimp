local Layer = require 'visimp.layer'
local layers = require 'visimp.loader'

---Prototype for language layers
---@class LanguageLayer: Layer
---@field public default_config {lsp: (string|boolean)?, lspconfig: table?}
local Language = Layer:new_layer ''

Language.default_config = {
  -- The LSP server to use. Defaults to nil (recommended LS) but users can
  -- also use alternatives. Can be set to false to disable this functionality
  lsp = nil,
  -- Optional configuration to be provided for the chosen language server
  lspconfig = nil,
}

---Returns an optional list of needed filetypes mappings
---@returns filetypes table? Filetypes mappings as described in
---https://neovim.io/doc/user/lua.html#vim.filetype.add()
function Language:filetypes()
  return nil
end

---Returns an optional list of Tree-sitter grammars
---@return string[]? grammars The optional list
function Language:grammars()
  return nil
end

---Returns the (optional) LSP name to install from Mason
---@returns string? lsp The name of the LSP
function Language:server()
  return nil
end

---Checks if a given table is empty or not
---@param t table The table to inspect
---@return boolean Result True if t is has no values in it, false otherwise
local function is_empty(t)
  return next(t) == nil
end

---Default implementation for "dependencies" method of language layers
---@return string[] dependencies List of dependencies
function Language:dependencies()
  local deps
  -- Tree-sitter
  local grammars = self:grammars()
  if type(grammars) ~= 'table' or is_empty(grammars) then
    deps = {}
  else
    deps = { 'treesitter' }
  end
  -- LSP
  if self.config.lsp ~= false then
    table.insert(deps, 'lsp')
  end
  return deps
end

---Adds new filetypes mappings
---@param filetypes table? Filetypes mappings as described in
---https://neovim.io/doc/user/lua.html#vim.filetype.add()
local function add_filetypes(filetypes)
  if filetypes then
    vim.filetype.add(filetypes)
  end
end

---Adds the specified languages to Tree-sitter
---@param grammars string[]? Array of Tree-sitter grammar names
local function add_grammars(grammars)
  if not grammars then
    return
  end
  local t = type(grammars)
  if t ~= 'table' then
    error('Grammars should be string array. Got ' .. t)
  end
  (layers.get 'treesitter' --[[@as TreesitterLayer]]):langs(grammars)
end

---Adds the appropriate language server based on the language layer
function Language:add_server()
  if self.config.lsp == false then -- explicitly disabled server
    return
  end
  local server = self:server() -- default server
  if not server then -- custom server
    server = self.config.lsp
  end
  if not server then -- no default server, no custom server
    return
  end
  local t = type(server)
  if t ~= 'string' then
    error('Server name should be string. Got ' .. t)
  end
  (layers.get 'lsp' --[[@as LspLayer]]):use_server(
    self.identifier,
    self.config.lsp == nil,
    server,
    self.config.lspconfig
  )
end

function Language:preload()
  add_filetypes(self:filetypes())
  add_grammars(self:grammars())
  self:add_server()
end

---Returns an new language layer for the given identifier
---@param id LayerId The layer identifier
---@return LanguageLayer layer The newly created layer
function Language:new_language(id)
  return self:new_layer(id) --[[@as LanguageLayer]]
end

return Language
