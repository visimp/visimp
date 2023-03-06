-- @module visimp.pak.init
local count = require('visimp.pak.count')
local window = require('visimp.pak.window')

local M = {
  pakdir = vim.fn.stdpath('data') .. '/site/pack/paks/',
  logfile = (
    vim.fn.has('nvim-0.8') == 1 and vim.fn.stdpath('log')
    or vim.fn.stdpath('cache')
  ) .. '/paq.log',
  sym_tbl = { install = '+', update = '*', remove = '-' },
  packages = {},
}

--- Fills the dialog with initial data on registered packages
function M.fill()
  count.set_status('')
  local keys = vim.tbl_keys(M.packages)
  table.sort(keys)
  local pkgs = {}
  for _, k in ipairs(keys) do
    pkgs[k] = '-'
  end
  count.updates(pkgs)
end

return M
