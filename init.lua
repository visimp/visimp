local visimp = require('visimp')
local gruvbox = require('visimp.themes.gruvbox')

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
  theme = gruvbox()
}
visimp.init()
