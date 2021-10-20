local M = {}

--- Returns an empty new layer for the given identifier
-- @param id A string used as the layer identifier
-- @return layer The newly created layer
function M.new_layer(id)
  local layer = {
    identifier = id,
    default_config = {},
    config = {},

    dependencies = function() return {} end,
    packages = function() return {} end,
    preload = function() end,
    load = function() end
  }
  function layer.configure(cfg)
    layer.config = vim.tbl_deep_extend('force', layer.default_config, cfg)
  end

  return layer
end

--- Returns true if the given argument is a proper layer
-- @param layer The hypothetical layer to analyze
-- @return A boolean value containing the result of the check
function M.is_layer(layer)
  return layer ~= nil and type(layer.identifier) == 'string' and
    layer.identifier ~= nil and type(layer.configure) == 'function' and
    type(layer.dependencies) == 'function' and type(packages) == 'function' and
    type(layer.load) == 'function'
end

return M
