local L = require('visimp.layer').new_layer 'diagnostics'
local bind = require('visimp.bind').bind
local get_module = require('visimp.bridge').get_module
local toggle = require('trouble').toggle

local function make_toggle(mode)
  return function()
    toggle(mode)
  end
end

-- Same as: https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
L.default_config = {
  trouble = {
    icons = false,
  },
  binds = {
    [{
      mode = 'n',
      bind = '<leader>tx',
      desc = 'Toggle diagnostics window',
    }] = toggle,
    [{
      mode = 'n',
      bind = '<leader>xw',
      desc = 'Workspace diagnostics',
    }] = make_toggle 'workspace_diagnostics',
    [{
      mode = 'n',
      bind = '<leader>xd',
      desc = 'Document diagnostics',
    }] = make_toggle 'document_diagnostics',
    [{
      mode = 'n',
      bind = '<leader>xq',
      desc = 'Quickfix',
    }] = make_toggle 'quickfix',
    [{
      mode = 'n',
      bind = '<leader>xl',
      desc = 'Diagnostics location list',
    }] = make_toggle 'loclist',
  },
}

function L.packages()
  return { 'folke/trouble.nvim' }
end

function L.preload()
  bind(L.config.binds, nil)
end

function L.load()
  get_module('trouble').setup(L.config)
end

return L
