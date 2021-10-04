local visimp = require('.')
local gruvbox = require('themes.gruvbox')

visimp.configs = {
  defaults = {
    folmethod = 'marker'
  },
  languages = {
    'c'
  },
  theme = gruvbox()
}
visimp.init()
