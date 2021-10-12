local loader = require('visimp.loader')
local layer = require('visimp.layer')
local layers = {'defaults', 'theme', 'treesitter', 'lsp', 'cmp', 'languages', 'telescope'}

function setup(config)
  -- Define all needed layers
  for i, l in ipairs(layers) do
    if type(l) == 'string' then
      loader.define_builtin(l)
    elseif layer.is_layer(l) then
      loader.define_layer(l)
      -- sanitize any custom layer into its id
      layers[i] = l.identifier
    else
      error('Invalid layer provided:\n' .. vim.inspect(layer))
    end
  end

  -- Configure layers
  for _, l in ipairs(layers) do
    local ll = loader.get(l)
    local cfg = config[ll.identifier] or {}
    loader.get(l).configure(cfg)
  end

  -- Check for cyclic dependecy graphs
  local dep = loader.are_cyclic({}, layers)
  if dep ~= nil then
    error('The selected layers cause a cyclic dependency graph (faulty: ' .. dep .. ')')
  end

  -- preload layers
  for _, l in ipairs(layers) do
    loader.preload(l)
  end

  -- TODO: pak auto install missing

  -- Load layers
  for _, l in ipairs(layers) do
    loader.load(l)
  end
end

return setup

