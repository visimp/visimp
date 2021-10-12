local visimp = require('visimp')
-- local gruvbox = require('visimp.themes.gruvbox')

visimp.configs = {
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
    'c', 'python'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
  -- theme = gruvbox()
  theme = {'lifepillar/vim-gruvbox8', 'gruvbox8', 'dark'}
}
visimp.init()
