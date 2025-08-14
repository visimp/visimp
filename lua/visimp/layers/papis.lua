local L = require('visimp.layer'):new_layer 'papis'
local get_module = require('visimp.bridge').get_module
local layers = require 'visimp.loader'

-- See https://github.com/jghauser/papis.nvim?tab=readme-ov-file#setup
L.default_config = {}

function L.dependencies()
  return { 'telescope', 'cmp', 'treesitter' }
end

function L.packages()
  return {
    'jghauser/papis.nvim',
    'kkharji/sqlite.lua',
    'MunifTanjim/nui.nvim',
    'pysan3/pathlib.nvim',
    'nvim-neotest/nvim-nio',
    'folke/snacks.nvim',
  }
end

---Ensures the YAML Tree-sitter grammar is installed (if it is required).
local function install_ts_yaml()
  local config = L.config
  if config and config.enable_modules and config.enable_modules.completion then
    local ts_layer = layers.get 'treesitter' --[[@as TreesitterLayer]]
    ts_layer:langs { 'yaml' }
  end
end

---Looks for the initial `init_filetypes` field in the user config. If this has
---not been specified, it is automatically populated based on the enabled
---language layers.
local function populate_init_filetypes()
  local config = L.config
  if config and not config.init_filetypes then
    local init_filetypes = {}
    for _, language in pairs(layers.get('languages').config) do
      if language == 'latex' then
        table.insert(init_filetypes, 'tex')
      elseif language == 'markdown' then
        table.insert(init_filetypes, 'markdown')
        table.insert(init_filetypes, 'rmd')
      elseif language == 'typst' then
        table.insert(init_filetypes, 'typst')
      end
    end
    config.init_filetypes = init_filetypes
  end
end

---Adds papis to the active cmp sources for autocompletion
local function add_cmp_source()
  table.insert(get_module('cmp').get_config().sources, { name = 'papis' })
end

function L.load()
  install_ts_yaml()
  populate_init_filetypes()
  get_module('papis').setup(L.config)
  add_cmp_source()
end

return L
