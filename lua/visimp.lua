local loader = require('visimp.loader')
local layer = require('visimp.layer')
local M = {}

M.layers = {'defaults', 'theme', 'treesitter', 'lsp', 'languages'}
M.languages = {}
M.configs = {}

function M.init()
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
  if loader.are_cyclic({}, M.layers) then
    error('The selected layers cause a cyclic dependency graph')
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
