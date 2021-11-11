local L = require('visimp.layer').new_layer('telescope')
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
    ['find_files'] = { mode = 'n', bind = '<leader>p' },
    ['live_grep'] = { mode = 'n', bind = '<leader>f' },
  },
}

function L.packages()
  return {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  }
end

function L.load()
  vim.cmd('packadd telescope.nvim')
  get_module('telescope').setup(L.config.config or {})

  local builtin = get_module('telescope.builtin')
  bind(L.config.binds, function(key)
    return builtin[key]
  end)
end

return L
