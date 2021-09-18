local l = require('layer')
local M = {
  layers = {},
  loaded = {}
}

--- Registers a new layer in the current configuration
-- @param layer The layer to register
function M.define_layer(layer)
  M.layers[layer.identifier] = layer
end

--- Attempts to require the given layer within the default configuration.
-- The procedure either throws an error or defines the layer.
-- @param id The layer identifier, by convention the same as the module name
function M.define_builtin(id)
  -- TODO: should be relative to the final module name
  local ok, module = pcall(require, 'layers.' .. id)
  if not ok then
    error('Requested invalid builtin layer: ' .. id)
  end

  M.define_layer(module)
end

--- Returns true if the list of layers have a cyclic relationship
-- @param loading A table of already loading packages
-- @param ... The list of layer identifiers
-- @return False if the list of layers does not produce a cyclic graph
function M.are_cyclic(loading, list)
  if list == nil or #list == 0 then
    return false
  end

  for _, id in ipairs(list) do
    if loading[id] then
      return true
    end

    loading[id] = true
    if M.are_cyclic(loading, M.layers[id].dependencies()) then
      return true
    end
  end

  return false
end

--- Fills the given packages list for all the needed packages by the requested
-- layers.
-- @param packs A table of initial packages
-- @param list A list of layer identifiers
function M.packages(packs, list)
  if list == nil or #list == 0 then
    return
  end

  for _, id in ipairs(list) do
    local l = M.layers[id]
    for _, v in ipairs(l.packages()) do 
      table.insert(packs, v)
    end
    M.packages(packs, l.dependencies())
  end
end

--- Loads a registered layer by its identifier with its dependecies.
-- This function also takes care of calling all the needed functions on each
-- layer to properly initialize your editor.
-- @param id The layer identifier
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
-- @param id The layer id
-- @return The requested layer
function M.get(id)
  if M.layers[id] == nil then
    error('Requested an undefined layer: ' .. id)
  end

  return M.layers[id]
end

return M
