--- Layer loader and (layer) dependency manager
-- @module visimp.loader
local M = {
  layers = {},
  packaged = {},
  preloaded = {},
  loaded = {},
  _packages = {},
}

--- Registers a new layer in the current configuration
-- @param layer string The layer to register
function M.define_layer(layer)
  if type(layer) ~= 'table' then
    error('Invalid layer format, expected a table, got: ' .. type(layer))
  end
  M.layers[layer.identifier] = layer
end

--- Attempts to require the given layer within the default configuration.
-- The procedure either throws an error or defines the layer.
-- @param id string The layer identifier, by convention the same as the module
--   name
function M.define_builtin(id)
  local ok, module = pcall(require, 'visimp.layers.' .. id)
  if not ok then
    error(
      'Requested invalid builtin layer: '
        .. id
        .. ' (resolved to '
        .. 'visimp.layers.'
        .. id
        .. ')\n'
        .. module
    )
  end

  M.define_layer(module)
end

--- Returns true if the requested layer is builtin (and can be loaded)
-- @param id string The layer identifier
-- @return bool Whether the layer is builtin
function M.is_builtin(id)
  local ok, _ = pcall(require, 'visimp.layers.' .. id)
  return ok
end

--- Returns true if the list of layers have a cyclic relationship
-- @param loading table A table of already loading packages
-- @param list list The list of layer identifiers
-- @return bool False if the list of layers does not produce a cyclic graph
function M.are_cyclic(loading, list)
  if list == nil or #list == 0 then
    return nil
  end

  for _, id in ipairs(list) do
    if loading[id] then
      return id
    end

    loading[id] = true
    local val = M.are_cyclic(loading, M.layers[id].dependencies())
    if val ~= nil then
      return val
    end
    loading[id] = false
  end

  return nil
end

--- Calls the package function for the given layer and its dependencies
-- @param id string The layer identifier
function M.packages(id)
  if M.packaged[id] then
    return
  end

  local layer = M.get(id)
  for _, did in ipairs(layer.dependencies()) do
    M.packages(did) -- did = Dependency IDentifier
  end

  vim.list_extend(M._packages, layer.packages() or {})
  M.packaged[id] = true
end

--- Calls the preaload function for the given layer and its dependencies
-- @param id string The layer identifier
function M.preload(id)
  if M.preloaded[id] then
    return
  end

  local layer = M.get(id)
  for _, did in ipairs(layer.dependencies()) do
    M.preload(did) -- did = Dependency IDentifier
  end

  layer.preload()
  M.preloaded[id] = true
end

--- Loads a registered layer by its identifier with its dependencies.
-- This function also takes care of calling all the needed functions on each
-- layer to properly initialize your editor.
-- @param id string The layer identifier
function M.load(id)
  if M.loaded[id] then
    return
  end

  local layer = M.get(id)
  for _, did in ipairs(layer.dependencies()) do
    M.load(did) -- did = Dependency IDentifier
  end

  layer.load()
  M.loaded[id] = true
end

--- Returns the requested layer by its id.
-- This function adds all needed safety checks to the dangerous M.layers[id]
-- access.
-- @param id string The layer id
-- @return any The requested layer
function M.get(id)
  if M.layers[id] == nil then
    error('Requested an undefined layer: ' .. id)
  end

  return M.layers[id]
end

--- Returns the list of required packages
-- @return list The list of required packages
function M.get_packages()
  return M._packages
end

return M
