local L = require('visimp.layer').new_layer('whichkey')
local get_module = require('visimp.bridge').get_module

-- TODO: this layer needs changes throughout the codebase to save all keymaps
-- along with descrption for them. This would make some eye candy which-key
-- displays.

-- All fields from https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
L.default_config = {
}

function L.packages()
  return { 'folke/which-key.nvim' }
end

function L.load()
  get_module('which-key').setup(L.config or {})
end

return L
