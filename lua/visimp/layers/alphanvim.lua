local L = require('visimp.layer').new_layer 'alphanvim'
local get_module = require('visimp.bridge').get_module
local fortune = require 'alpha.fortune'

function L.packages()
  return { 'goolord/alpha-nvim' }
end

local function default_layout()
  local header = {
    type = 'text',
    val = {
      ' _    __                     ',
      '| |  / (_)____(_)___ ___  ____ ',
      '| | / / / ___/ / __ `__ \\/ __ \\',
      '| |/ / (__  ) / / / / / / /_/ /',
      '|___/_/____/_/_/ /_/ /_/ .___/ ',
      '                      /_/',
    },
    opts = {
      position = 'center',
      hl = 'Type',
    },
  }

  local footer = {
    type = 'text',
    val = fortune(),
    opts = {
      position = 'center',
      hl = 'Number',
    },
  }

  return {
    layout = {
      { type = 'padding', val = 12 },
      header,
      { type = 'padding', val = 2 },
      footer,
    },
    opts = {
      margin = 5,
    },
  }
end

L.default_config = default_layout()

function L.load()
  get_module('alpha').setup(L.config)
end

return L
