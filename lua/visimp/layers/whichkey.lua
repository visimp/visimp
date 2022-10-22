local L = require('visimp.layer').new_layer('whichkey')
local get_module = require('visimp.bridge').get_module
local get_registered = require('visimp.bind').get_registered
local get_layer = require('visimp.loader').get

-- All fields from https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
L.default_config = {}

function L.dependencies()
  return { 'lsp' }
end

function L.packages()
  return { 'folke/which-key.nvim' }
end

function L.load()
  get_module('which-key').setup(L.config or {})
  get_layer('lsp').on_attach(L.register_all)
  L.register_all()
end

function L.register_all()
  local whichkey = get_module('which-key')
  local defs = {}
  for _, l in ipairs(get_registered()) do
    defs[l.bind] = l.desc or l.rhs or ''
  end
  whichkey.register(defs)
end

return L
