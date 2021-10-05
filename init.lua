local visimp = require('.')
local gruvbox = require('themes.gruvbox')

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
