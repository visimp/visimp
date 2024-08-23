local L = require('visimp.layer').new_layer 'diagnostics'
local bind = require('visimp.bind').bind
local get_module = require('visimp.bridge').get_module

---Returns a function toggling the view with the given mode and filters.
---@param mode string Mode to be toggled
---@param filters? string Optional filters
---@return function
local function make_toggle(mode, filters)
  return function()
    if not filters then
      filters = ''
    end
    vim.cmd('Trouble ' .. mode .. ' toggle ' .. filters)
  end
end

L.default_config = {
  ---Same as: https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
  trouble = {},
  binds = {
    [{
      mode = 'n',
      bind = '<leader>xx',
      desc = 'Diagnostics',
    }] = make_toggle 'diagnostics',
    [{
      mode = 'n',
      bind = '<leader>xX',
      desc = 'Buffer Diagnostics',
    }] = make_toggle('diagnostics', 'filter.buf=0'),
    [{
      mode = 'n',
      bind = '<leader>cs',
      desc = 'Symbols',
    }] = make_toggle('symbols', 'focus=false'),
    [{
      mode = 'n',
      bind = '<leader>cl',
      desc = 'LSP definitions/references/...',
    }] = make_toggle('lsp', 'focus=false win.position=right'),
    [{
      mode = 'n',
      bind = '<leader>xL',
      desc = 'Location list',
    }] = make_toggle 'loclist',
    [{
      mode = 'n',
      bind = '<leader>xQ',
      desc = 'Quickfix list',
    }] = make_toggle 'qflist',
  },
}

function L.dependencies()
  return {
    'lsp',
  }
end

function L.packages()
  return {
    'folke/trouble.nvim',
  }
end

function L.load()
  get_module('trouble').setup(L.config.trouble)
  bind(L.config.binds, nil)
end

return L
