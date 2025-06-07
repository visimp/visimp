---@alias LayerId string

---A visimp functionality
---@class Layer
---@field public identifier LayerId A unique, human-readable identifier
---@field public default_config table The default configuration of the layer
---@field public config table The current user configuration for this layer
---@field public deprecated boolean Whether the layer has been deprecated
local Layer = {
  default_config = {},
  config = {},
  deprecated = false,
}

---@alias PackageSlug string

---A (Neo)vim plugin
---@class Package
---@field public url string? A git repository URL. If unspecified, the field
---with (implicit) key `1` will be treated as `username/repository` of a GitHub
---repository
---@field public branch string? Possible non-default branch name to use
---@field public opt boolean? Whether the plugin is optionally not needed by the
---layer. If it is not needed, it will not be loaded automatically at startup.

---Returns a list of dependency layers
---@return LayerId[] dep A list of identifiers for the dependency layers
function Layer:dependencies()
  return {}
end

---Returns a list of dependency packages (i.e., (Neo)vim plugins). Each can be
---specified as either a simple GitH*b repository name (`user/repository`), or
---using the appropriate class.
---@return (PackageSlug|Package)[] dep A list of repo names or full-fledged
---packages
function Layer:packages()
  return {}
end

---A handler which is called on all layers before the load method is called on
---any of them. This is used to modify behavior of other layers’ load methods.
function Layer:preload()
  return {}
end

---A handler designed to let layers apply side effects on the Neovim client.
---This is where plugins are enabled, the Neovim configuration is set, etcetera.
function Layer:load()
  return {}
end

---Replaces the current configuration with the result of recursively extending
---the default layer configuration with the given value.
---@param cfg table The settings used to extend the default layer configuration
function Layer:configure(cfg)
  self.config = vim.tbl_deep_extend('force', self.default_config, cfg)
end

---Returns an empty new layer for the given identifier
---@param id LayerId The layer identifier
---@return Layer layer The newly created layer
function Layer:new_layer(id)
  local layer = { identifier = id }
  setmetatable(layer, self)
  self.__index = self
  return layer
end

---Returns true if the given argument is a proper layer
---@param layer any The hypothetical layer to analyze
---@return boolean result Whether the provided argument is a layer
function Layer.is_layer(layer)
  return type(layer) == 'table'
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

---Exports a layer config as a vimscript plugin config (i.e., vim global
---variables)
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
---@param blacklist string[]|nil A list of fields that should not be copied from
-- the layer config (as they do not belong to the plugin config). If nil, it is
-- considered to be empty.
function Layer:to_vimscript_config(
  vim_config_field,
  prefix_mode,
  layer_config_field,
  blacklist
)
  -- Config source
  local layer_config = self.config
  if layer_config_field then
    layer_config = layer_config[layer_config_field]
  end
  -- Config destination
  local vim_config = vim.g
  if not prefix_mode then
    if vim_config[vim_config_field] == nil then
      vim_config[vim_config_field] = {}
    end
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

return Layer
