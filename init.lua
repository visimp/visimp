-- TODO: customize
vim.cmd 'packadd paq-nvim'
local visimp = require('.')
local gruvbox = require('themes.gruvbox')

visimp.configs = {
  defaults = {
    folmethod = 'marker'
  },
  theme = gruvbox()
}
visimp.init()
