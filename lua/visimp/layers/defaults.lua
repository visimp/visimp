local L = require('visimp.layer').new_layer('defaults')
local bridge = require('visimp.bridge')
local opt = bridge.opt
local vfn = bridge.vfn
local get_module = bridge.get_module

L.default_config = {
  mapleader = ' ',

  relativenumber = true,
  foldmethod = nil,
  indent = 2,

  scrolloff = 5,
  sidescrolloff = 10,
  colorcolumn = 80,
  completeopt = 'menuone,noinsert,noselect'
}

function L.packages()
  return { 'lewis6991/impatient.nvim' }
end

function L.load()
  get_module('impatient')

  opt('o', 'swapfile', false) -- Do not use swap files
  opt('o', 'backup', false) -- Do not use backups
  opt('o', 'writebackup', false) -- Do not write backups
  opt('o', 'undofile', true) -- Use undo files
  opt('o', 'undodir', vfn('stdpath', { 'data' }) .. '/undo') -- Set the undodir to $XDG_DATA/nvim/undo
  opt('o', 'updatetime', 50) -- Make vim's updates quicker so it feels snappier
  opt('o', 'hidden', true) -- Don't show verbose messages on the bottom
  opt('o', 'showmode', false) -- Shows the mode in the status line
  opt('o', 'termguicolors', true) -- Enable true colors in modern terminals

  opt('o', 'incsearch', true) -- Search while typing (incrementally)
  opt('o', 'hlsearch', false) -- Do not hightlight searches
  opt('o', 'showmatch', false) -- Do not show search matched words in files
  opt('o', 'smartcase', true) -- Ignore case when searching if everything is lowercase

  opt('w', 'wrap', false) -- Do not wrap lines
  opt('w', 'number', true) -- Add line numbers to the left gutter
  opt('w', 'relativenumber', L.config.relativenumber) -- Make line numbers relative
  if L.config.foldmethod ~= nil then
    opt('w', 'foldmethod', L.config.foldmethod) -- Fold with {{{ and }}} markers
  end
  opt('o', 'scrolloff', L.config.scrolloff) -- Leave n lines from the bottom while scrolling down
  opt('o', 'sidescrolloff', L.config.sidescrolloff) -- Leave n lines frm the right while scrolling right
  opt('w', 'colorcolumn', tostring(L.config.colorcolumn)) -- Show a column ruler at 80 chars

  opt('b', 'tabstop', L.config.indent) -- Number of spaces each tab shows
  opt('b', 'expandtab', true) -- Use spaces when tab is hit
  opt('b', 'shiftwidth', L.config.indent) -- Size on an indent (< or >)
  opt('b', 'smartindent', true) -- Uses tabs/spaces wisely where needed

  vim.cmd('syntax enable') -- Enable syntax highlighting
  opt('o', 'completeopt', L.config.completeopt) -- Define how completion works
  vim.g.mapleader = L.config.mapleader -- Leader key for mappings
end

return L
