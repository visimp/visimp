local L = require('visimp.layer'):new_layer 'neogit'
local get_module = require('visimp.bridge').get_module

---All fields from https://github.com/NeogitOrg/neogit#configuration
---are accepted here.
L.default_config = {}

function L.dependencies()
  return { 'telescope' }
end

function L.packages()
  return {
    'nvim-lua/plenary.nvim',
    'NeogitOrg/neogit',
  }
end

function L.load()
  get_module('neogit').setup(L.config or {})
end

return L
