local L = require('visimp.layer').new_layer 'alphanvim'
local get_module = require('visimp.bridge').get_module
local visimp_ver = "1.42"

function L.packages()
  return { 'goolord/alpha-nvim' }
end


local dashboard = get_module('alpha.themes.dashboard')
local fortune =  require('alpha.fortune')

dashboard.section.header.val = {
" _    __                     ",
"| |  / (_)____(_)___ ___  ____ ",
"| | / / / ___/ / __ `__ \\/ __ \\",
"| |/ / (__  ) / / / / / / /_/ /",
"|___/_/____/_/_/ /_/ /_/ .___/ ",
"                      /_/",
"visimp: " .. tostring(visimp_ver),
"nvim: " .. tostring(vim.version())
}
dashboard.section.buttons.val = {}

dashboard.section.footer.val = fortune()

L.default_config = dashboard.opts

function L.load()
  get_module('alpha').setup(L.config)
end

return L
