local L = require('visimp.layer').new_layer('telescope')
local package = require('visimp.pak').register
local get_module = require('visimp.utils').get_module
local map = require('visimp.utils').map

L.default_config = {
  binds = {
    ['find_files'] = { mode = 'n', bind = '<leader>p' },
    ['live_grep'] = { mode = 'n', bind = '<leader>f' }
  }
}

function L.preload()
  package('nvim-lua/plenary.nvim')
  package('nvim-telescope/telescope.nvim')
end

function L.load()
  vim.cmd('packadd telescope.nvim')
  local telescope = get_module('telescope.builtin')

  for k, v in pairs(L.config.binds) do
    local m = L.config.binds[k]
    m.fn = function()
      telescope[k]()
    end
    map(m)
  end
end

return L
