local L = require('visimp.layer').new_layer('diagnostics')
local get_module = require('visimp.bridge').get_module

-- Same as: https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
L.default_config = {
  icons = false
}

function L.packages()
  return { 'folke/trouble.nvim' }
end

function L.load()
  get_module('trouble').setup(L.config)
end

return L

