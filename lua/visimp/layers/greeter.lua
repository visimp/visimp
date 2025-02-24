local L = require('visimp.layer').new_layer 'greeter'
local get_module = require('visimp.bridge').get_module

function L.packages()
  return { 'goolord/alpha-nvim' }
end

---A human-readable phrase describing Neovim's current version
---@return string phrase The version's description
local function vim_version()
  return 'running on NVIM v' .. tostring(vim.version())
end

---Default greeter
---@return table layout alpha-nvim layout describing visimp's default greeter
local function default_layout()
  local fortune = get_module 'alpha.fortune'

  local header = {
    type = 'text',
    val = {
      ' _    __                     ',
      '| |  / (_)____(_)___ ___  ____ ',
      '| | / / / ___/ / __ `__ \\/ __ \\',
      '| |/ / (__  ) / / / / / / /_/ /',
      '|___/_/____/_/_/ /_/ /_/ .___/ ',
      '                      /_/',
    },
    opts = {
      position = 'center',
      hl = 'Title',
    },
  }

  local version = {
    type = 'text',
    val = vim_version(),
    opts = {
      position = 'center',
      hl = 'Normal',
    },
  }

  local continue = {
    type = 'button',
    val = '',
    opts = { position = 'center' },
    on_press = function()
      vim.cmd 'ene'
      vim.cmd 'startinsert'
    end,
  }

  local footer = {
    type = 'text',
    val = fortune(),
    opts = {
      position = 'center',
      hl = 'String',
    },
  }

  return {
    layout = {
      { type = 'padding', val = 12 },
      header,
      { type = 'padding', val = 1 },
      version,
      { type = 'padding', val = 1 },
      continue,
      footer,
    },
    opts = {
      margin = 5,
      keymap = {
        press = { 'a', 'i', 'o', '<CR>' },
      },
    },
  }
end

L.default_config = {}

function L.load()
  if L.config.layout == nil then
    L.config = {
      layout = default_layout(),
    }
  end

  get_module('alpha').setup(L.config.layout)
end

return L
