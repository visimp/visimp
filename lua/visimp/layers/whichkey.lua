local L = require('visimp.layer').new_layer 'whichkey'
local get_module = require('visimp.bridge').get_module
local get_visimp_registered = require('visimp.bind').get_registered
local get_layer = require('visimp.loader').get

-- All fields from
-- https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
L.default_config = {}

function L.dependencies()
  return { 'lsp' }
end

function L.packages()
  return { 'folke/which-key.nvim' }
end

function L.load()
  get_module('which-key').setup(L.config or {})
  local lsp = get_layer 'lsp'
  lsp.on_attach(function()
    L.register(lsp.config.binds)
  end)
  L.register_all()
end

---Maps a function over a list, generating a new list with the output values.
---The original list is left inaltered.
---@param f function The function producing the output values
---@param l table The list to map over
---@return table res The resulting list
local function map(f, l)
  local res = {}
  for i, v in ipairs(l) do
    table.insert(res, i, f(v))
  end
  return res
end

---Converts a bind table from the [visimp format](../../../docs/layers/BINDS.md)
---to the [which-key
---format](https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings).
---@param visimp_bind table A bind in the visimp format
---@return table out A bind in the which-key format
local function visimp_bind_to_whichkey_bind(visimp_bind)
  return {
    visimp_bind.bind,
    desc = visimp_bind.desc or visimp_bind.rhs or '',
    mode = visimp_bind.mode,
  }
end

---Generates a new table with all current bindings managed by visimp. All the
---bindings are presented in the [which-key
---format](https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings).
---@return table out The generated table
local function visimp_binds_to_whichkey_binds(visimp_binds)
  return map(visimp_bind_to_whichkey_bind, visimp_binds)
end

---Registers some bindings passed in the [visimp
---format](../../../docs/layers/BINDS.md).
---@param binds table List of binds to register.
function L.register(binds)
  get_module('which-key').add(visimp_binds_to_whichkey_binds(binds))
end

---Registers all bindings currently known by visimp. Bindings are already
---registered by this plugin at loading time, so invoking this method by
---register some bindings a second time.
function L.register_all()
  L.register(get_visimp_registered())
end

return L
