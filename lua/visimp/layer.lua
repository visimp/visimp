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

return M
