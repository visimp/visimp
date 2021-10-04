-- TODO: customize
vim.cmd 'packadd paq-nvim'

local loader = require('loader')
local layer = require('layer')
local M = {}

M.layers = {'defaults', 'theme', 'treesitter', 'languages'}
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
    local cfg = ll.default_config
    if M.configs[ll.identifier] ~= nil then
      cfg = M.configs[ll.identifier]
    end

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

  -- require'paq-nvim'.sync()

  -- Load layers
  for _, l in ipairs(M.layers) do
    loader.load(l)
  end
end

return M
