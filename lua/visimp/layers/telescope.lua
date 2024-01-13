local L = require('visimp.layer').new_layer 'telescope'
local get_module = require('visimp.bridge').get_module
local bind = require('visimp.bind').bind

L.default_config = {
  config = {
    defaults = {
      borderchars = {
        '─',
        '│',
        '─',
        '│',
        '┌',
        '┐',
        '┘',
        '└',
      },
    },
  },
  binds = {
    [{
      mode = 'n',
      bind = '<leader>p',
      desc = 'Find files by their name',
    }] = 'find_files',
    [{
      mode = 'n',
      bind = '<leader>f',
      desc = 'Search through files content',
    }] = 'live_grep',
  },
}

function L.packages()
  return {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  }
end

function L.load()
  vim.cmd 'packadd telescope.nvim'
  get_module('telescope').setup(L.config.config or {})

  local builtin = get_module 'telescope.builtin'
  bind(L.config.binds, function(key)
    return builtin[key]
  end)
end

return L
