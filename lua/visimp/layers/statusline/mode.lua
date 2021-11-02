-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
-- taken from https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua
-- and modified as needed

local maps = {
  ['n'] = 'N',
  ['no'] = 'O',
  ['nov'] = 'O',
  ['noV'] = 'O',
  ['no'] = 'O',
  ['niI'] = 'N',
  ['niR'] = 'N',
  ['niV'] = 'N',
  ['nt'] = 'N',
  ['v'] = 'V',
  ['vs'] = 'V',
  ['V'] = 'V',
  ['Vs'] = 'V',
  [''] = 'V',
  ['s'] = 'V',
  ['s'] = 'S',
  ['S'] = 'S',
  [''] = 'S',
  ['i'] = 'I',
  ['ic'] = 'I',
  ['ix'] = 'I',
  ['R'] = 'R',
  ['Rc'] = 'R',
  ['Rx'] = 'R',
  ['Rv'] = 'R',
  ['Rvc'] = 'R',
  ['Rvx'] = 'R',
  ['c'] = 'C',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'R',
  ['rm'] = 'M',
  ['r?'] = 'C',
  ['!'] = 'S',
  ['t'] = 'T',
}

--- Returns a single char to identify the vi mode
-- @return single char mode
function get_mode()
  local mode_code = vim.api.nvim_get_mode().mode
  if maps[mode_code] == nil then
    return mode_code
  end
  return maps[mode_code]
end

return get_mode
