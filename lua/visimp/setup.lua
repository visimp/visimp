local loader = require('visimp.loader')
local layer = require('visimp.layer')
local package = require('visimp.pak').register
local contains = require('visimp.utils').contains

local M = {
  layers = {'defaults', 'theme', 'treesitter', 'lsp', 'cmp', 'languages', 'telescope', 'comment'},
  configs = {}
}

function M.setup(cfg)
  M.configs = cfg or {}
  package('lucat1/visimp') -- Let visimp be updated by the package manager

  -- disable/enable layers which are set to false in the config/configured and
  -- not enabled by default
  for k, v in pairs(M.configs) do
    if v == false then
      -- disable any undesired layer
      table.remove(M.layers, k)
    elseif not contains(M.layers, k) and loader.is_builtin(k) then
      -- enable any missing builtin layer
      table.insert(M.layers, k)
    end
  end

  -- Define all needed layers
  for i, l in ipairs(M.layers) do
    if type(l) == 'string' then
      loader.define_builtin(l)
    elseif layer.is_layer(l) then
      loader.define_layer(l)
      -- sanitize any custom layer into its id
      M.layers[i] = l.identifier
    else
      error('Invalid layer provided:\n' .. vim.inspect(layer))
    end
  end

  -- Configure layers
  for _, l in ipairs(M.layers) do
    local ll = loader.get(l)
    local cfg = M.configs[ll.identifier] or {}
    loader.get(l).configure(cfg)
  end

  -- Check for cyclic dependecy graphs
  local dep = loader.are_cyclic({}, M.layers)
  if dep ~= nil then
    error('The selected layers cause a cyclic dependency graph (faulty: ' .. dep .. ')')
  end

  -- preload layers
  for _, l in ipairs(M.layers) do
    loader.preload(l)
  end

  -- TODO: pak auto install missing

  -- Load layers
  for _, l in ipairs(M.layers) do
    loader.load(l)
  end
end

return M
