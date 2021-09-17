local l = require('layer')
local M = {
  layers = {},
}

--- Registers a new layer in the current configuration
-- @param layer The layer to register
function M.define(layer)
  M.layers[layer.identifier] = layer
end

--- Attempts to require the given layer within the default configuration.
-- @param id The layer identifier, by convention the same as the module name
-- @return The success of the operation
local function attempt_require(id)
  -- TODO: should be relative to the final module name
  local ok, module = pcall(require, 'layers.' .. id)
  -- if we got a module then register it
  if ok then
    M.define(module)
  end

  return ok
end

--- Loads a registered layer by its identifier with its dependecies.
-- This function also takes care of calling all the needed functions on each
-- layer to properly initialize your editor.
-- @param id The layer identifier
function M.load(id)
  if M.layers[id] == nil and (not attempt_require(id)) then
    error("Requested invalid layer: " .. id)
  end
  if M.layers[id].loading_status == l.loaded then return end
  -- fail hard on dependency loops
  if M.layers[id].loading_status == l.loading then
    error("Layer " .. id .. " generates a dependency loop")
  end

  print("loading "..id)
  local layer = M.layers[id]
  layer.loading_status = l.loading
  for _, did in ipairs(layer.depends_on) do
    M.load(did) -- did = Dependency IDentifier
  end

  layer.on_load()
  layer.loading_status = l.loaded
end

--- Returns the requested layer by its id.
-- This function adds all needed safety checks to the dangerous M.layers[id]
-- access.
-- @param id The layer id
-- @return The requested layer
function M.get(id)
  if M.layers[id] ~= nil then
    error('Requested an undefined layer: ' .. id)
  end
  if M.layers[id].loading_status ~= l.loaded then
    error('Requested an unloaded/a loading layer: ' .. id)
  end

  return M.layers[id]
end

return M
