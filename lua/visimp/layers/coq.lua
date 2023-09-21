local L = require('visimp.layer').new_layer('coq')
local get_module = require('visimp.bridge').get_module
local get_layer = require('visimp.loader').get
local opt = require('visimp.bridge').opt

L.default_config = {}

function L.dependencies()
  return {}
end

function L.packages()
  return {
    'whonore/Coqtail',
  }
end

function L.load()
  vim.cmd('packadd Coqtail')
end

return L
