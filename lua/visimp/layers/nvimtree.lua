local L = require('visimp.layer').new_layer 'nvimtree'
local get_module = require('visimp.bridge').get_module

---For nvim-tree default config see https://github.com/nvim-tree/nvim-tree.lua
L.default_config = {
  icons = false,
}

function L.packages()
  return {
    'nvim-tree/nvim-tree.lua',
  }
end

function L.dependencies()
  if L.config.icons then
    return { 'icons' }
  end
  return {}
end

local function shallow_copy(t)
  local u = {}
  for k, v in pairs(t) do
    u[k] = v
  end
  return setmetatable(u, getmetatable(t))
end

function L.load()
  local config = shallow_copy(L.config)
  config.icons = nil
  get_module('nvim-tree').setup(config)
end

return L
