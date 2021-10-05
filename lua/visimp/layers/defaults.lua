local L = require('visimp.layer').new_layer('defaults')
local utils = require('visimp.utils')
local opt = utils.opt
local vfn = utils.vfn

L.default_config = {
  relativenumber = true,
  foldmethod = nil,
  indent = 2,

  scrolloff = 5,
  sidescrolloff = 10,
  colorcolumn = 80
}

function L.load()
  opt('o', 'swapfile', false)                                                  -- do not use swap files
  opt('o', 'backup', false)                                                    -- do not use backups
  opt('o', 'writebackup', false)                                               -- do not write backups
  opt('o', 'undofile', true)                                                   -- use undo files
  opt('o', 'undodir', vfn('stdpath', {"data"}) .. "/undo")                     -- set the undodir to $XDG_DATA/nvim/undo
  opt('o', 'updatetime', 50)                                                   -- make vim's updates quicker so it feels snappier
  opt('o', 'hidden', true)                                                     -- don't show verbose messages on the bottom
  opt('o', 'showmode', false)                                                  -- shows the mode in the status line
  opt('o', 'termguicolors', true)                                              -- enable true colors in modern terminals

  opt('o', 'incsearch', true)                                                  -- search while typing (incrementally)
  opt('o', 'hlsearch', false)                                                  -- do not hightlight searches 
  opt('o', 'showmatch', false)                                                 -- do not show search matched words in files
  opt('o', 'smartcase', true)                                                  -- ignore case when searching if everything is lowercase

  opt('w', 'wrap', false)                                                      -- do not wrap lines
  opt('w', 'number', true)                                                     -- add line numbers to the left gutter
  opt('w', 'relativenumber', L.config.relativenumber)                          -- make line numbers relative
  if L.config.foldmethod ~= nil then
    opt('w', 'foldmethod', L.config.foldmethod)                                -- fold with {{{ and }}} markers
  end
  opt('o', 'scrolloff', L.config.scrolloff)                                    -- leave n lines from the bottom while scrolling down
  opt('o', 'sidescrolloff', L.config.sidescrolloff)                            -- leave n lines frm the right while scrolling right
  opt('w', 'colorcolumn', tostring(L.config.colorcolumn))                      -- show a column ruler at 80 chars

  opt('b', 'tabstop', L.config.indent)                                         -- number of spaces each tab shows
  opt('b', 'expandtab', true)                                                  -- use spaces when tab is hit
  opt('b', 'shiftwidth', L.config.indent)                                      -- size on an indent (< or >)
  opt('b', 'smartindent', true)                                                -- uses tabs/spaces wisely where needed
end

return L
