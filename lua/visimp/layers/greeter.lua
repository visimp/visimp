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

---A substring to be used to represent the leader button (space) on screen.
local leader = 'SPC'

---From
---https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/startify.lua
---@param sc string
---@param txt string
---@param keybind string? optional
---@param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

  local opts = {
    position = 'center',
    shortcut = '[' .. sc .. '] ',
    cursor = 1,
    -- width = 50,
    align_shortcut = 'left',
    hl_shortcut = {
      { 'Operator', 0, 1 },
      { 'Number', 1, #sc + 1 },
      { 'Operator', #sc + 1, #sc + 2 },
    },
    shrink_margin = false,
  }
  if keybind then
    keybind_opts = vim.F.if_nil(
      keybind_opts,
      { noremap = true, silent = true, nowait = true }
    )
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key =
      vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
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
      { type = 'padding', val = 2 },
      version,
      { type = 'padding', val = 2 },
      footer,
      { type = 'padding', val = 2 },
      button('e', 'New file', '<cmd>ene | startinsert <CR>'),
    },
    opts = {
      margin = 5,
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
