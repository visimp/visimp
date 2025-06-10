local Layer = require 'visimp.layer'

---Layer loader and (layer) dependency manager
local M = {
  layers = {},
  packaged = {},
  preloaded = {},
  loaded = {},
  _packages = {},
}

---Registers a new layer in the current configuration
--@param layer string The layer to register
function M.define_layer(layer)
  if type(layer) ~= 'table' then
    error('Invalid layer format, expected a table, got: ' .. type(layer))
  end
  M.layers[layer.identifier] = layer
end

---Attempts to require the given layer within the default configuration.
---The procedure either throws an error or defines the layer.
---@param id string The layer identifier, by convention the same as the module
---name
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

---Returns true if the requested layer is builtin (and can be loaded)
---@param id string The layer identifier
---@return boolean Whether the layer is builtin
function M.is_builtin(id)
  local ok, _ = pcall(require, 'visimp.layers.' .. id)
  return ok
end

---Returns true if the list of layers have a cyclic relationship
---@param loading table A table of already loading layers
---@param list (string[])|nil The list of layer identifiers
---@return string|nil return The id of the layer being cyclically required, or
---nil if no loop was found.
function M.are_cyclic(loading, list)
  if list == nil or #list == 0 then
    return nil
  end

  for _, id in ipairs(list) do
    if not M.layers[id] then
      error(
        'Layer '
          .. id
          .. ' was listed as dependency, but is not enabled. '
          .. 'Please make sure it is not set to "false" in your config.'
      )
    end
    if loading[id] then
      return id
    end

    loading[id] = true
    local val = M.are_cyclic(loading, M.layers[id]:dependencies())
    if val ~= nil then
      return val
    end
    loading[id] = false
  end

  return nil
end

---Calls the package function for the given layer and its dependencies
---@param id string The layer identifier
function M.packages(id)
  if M.packaged[id] then
    return
  end

  local layer = M.get(id)
  for _, did in ipairs(layer:dependencies()) do
    M.packages(did) -- did = Dependency IDentifier
  end

  vim.list_extend(M._packages, layer:packages() or {})
  M.packaged[id] = true
end

---Calls the preaload function for the given layer and its dependencies
---@param l LayerId|Layer The layer (identifier)
function M.preload(l)
  if Layer.is_layer(l) then
    l = l.identifier
  end
  ---@cast l LayerId
  if M.preloaded[l] then
    return
  end

  local layer = M.get(l)
  for _, did in ipairs(layer:dependencies()) do
    M.preload(did) -- did = Dependency IDentifier
  end

  layer:preload()
  M.preloaded[l] = true
end

---Prints a warning message in case the layer is deprecated.
---@param layer table The layer to be analyzed
local function deprecation_check(layer)
  if layer.deprecated then
    print(
      'The "'
        .. layer.identifier
        .. '" layer is deprecated and shall not be used. Please disable it.'
    )
  end
end

---Loads a registered layer by its identifier with its dependencies.
---This function also takes care of calling all the needed functions on each
---layer to properly initialize your editor.
---@param l LayerId|Layer The layer identifier
function M.load(l)
  if Layer.is_layer(l) then
    l = l.identifier
    ---@cast l LayerId
  end
  if M.loaded[l] then
    return
  end

  local layer = M.get(l)
  for _, did in ipairs(layer:dependencies()) do
    M.load(did) -- did = Dependency IDentifier
  end

  deprecation_check(layer)
  layer:load()
  M.loaded[l] = true
end

---Returns the requested layer by its id.
---This function adds all needed safety checks to the dangerous M.layers[id]
---access.
---@param id LayerId The layer id
---@return Layer layer The requested layer
function M.get(id)
  if M.layers[id] == nil then
    error('Requested an undefined layer: ' .. id)
  end

  return M.layers[id]
end

---Returns the list of required packages
---@return (PackageSlug|Package)[] packages The list of required packages
function M.get_packages()
  return M._packages
end

return M
