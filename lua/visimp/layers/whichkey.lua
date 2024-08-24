local L = require('visimp.layer').new_layer 'whichkey'
local get_module = require('visimp.bridge').get_module

---All fields from
---https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
L.default_config = {}

function L.dependencies()
  return { 'lsp' }
end

function L.packages()
  return { 'folke/which-key.nvim' }
end

function L.load()
  get_module('which-key').setup(L.config or {})
end

---Wrapper for `whichkey`'s `add` method.
---@param mappings table List of mappings to be added manually. Normally,
---mappings are added without any need to invoke this method.
function L.add(mappings)
  get_module('which-key').add(mappings)
end

return L
