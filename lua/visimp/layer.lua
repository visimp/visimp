--- Utilities for constructing and identifying layers
-- @module visimp.layer
local M = {}

--- Returns an empty new layer for the given identifier
-- @param id The layer identifier
-- @return The newly created layer
function M.new_layer(id)
  local layer = {
    identifier = id,
    default_config = {},
    config = {},

    dependencies = function()
      return {}
    end,
    packages = function()
      return {}
    end,
    preload = function() end,
    load = function() end,
  }
  function layer.configure(cfg)
    layer.config = vim.tbl_deep_extend('force', layer.default_config, cfg)
  end

  return layer
end

--- Returns true if the given argument is a proper layer
-- @param layer The hypothetical layer to analyze
-- @return Whether the provided argument is a layer
function M.is_layer(layer)
  return layer ~= nil
    and type(layer.identifier) == 'string'
    and layer.identifier ~= nil
    and type(layer.configure) == 'function'
    and type(layer.dependencies) == 'function'
    and type(layer.packages) == 'function'
    and type(layer.load) == 'function'
end

---Set constructor from list
---@param list table An initializer list
---@return table The resulting set
local function Set(list)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set
end

--- Exports a layer config as a vimscript plugin config (i.e., vim global
--- variables)
---@param layer table The layer whose config is to be exported
---@param vim_config_field string The name of the global vimscript variable
-- storing the plugin config, or the common prefix shared by all the plugin
-- config fields if these are stored as individual vimscript global variables.
---@param prefix_mode boolean True(ish) if the vim_config_field parameter should
-- be interpreted as a prefix common to all the plugin config fields, or
-- false(ish) if it should just be the global vimscript variable storing the
-- plugin config.
---@param layer_config_field string|nil The field in the layer config where the
-- plugin config is stored. If the plugin config is stored at the root of the
-- layer config, nil should be passed instead.
---@param blacklist table|nil A list of fields that should not be copied from
-- the layer config (as they do not belong to the plugin config). If nil, it is
-- considered to be empty.
function M.to_vimscript_config(
  layer,
  vim_config_field,
  prefix_mode,
  layer_config_field,
  blacklist
)
  -- Config source
  local layer_config = layer.config
  if layer_config_field then
    layer_config = layer_config[layer_config_field]
  end
  -- Config destination
  local vim_config = vim.g
  if not prefix_mode then
    vim_config = vim_config[vim_config_field]
  end
  -- Blacklist
  if blacklist then
    blacklist = Set(blacklist)
  end
  -- Copy
  for key, value in pairs(layer_config) do
    if not blacklist or not blacklist[key] then
      if prefix_mode then
        key = vim_config_field .. key
      end
      vim_config[key] = value
    end
  end
end

return M
