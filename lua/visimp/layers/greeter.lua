local L = require('visimp.layer').new_layer 'greeter'
local get_module = require('visimp.bridge').get_module

function L.packages()
  return { 'goolord/alpha-nvim' }
end

local function default_layout()
  local fortune = get_module 'alpha.fortune'

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

      -- Accordingly to alpha-nvim doc, this empty button component is required
      -- for the correct placement of the cursor while the greeter is displayed
      { type = 'button', val = '' },

      footer,
    },
    opts = {
      margin = 5,
    },
  }
end

L.default_config = {}

function L.load()
  if L.config.layout == nil then
    L.config = {
      layout = default_layout(),
    }
  end

  get_module('alpha').setup(L.config.layout)
end

return L
