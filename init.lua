local visimp = require('visimp')
local gruvbox = require('visimp.themes.gruvbox')

visimp.configs = {
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
    'c'
  },
  theme = gruvbox()
}
visimp.init()
