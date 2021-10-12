local M = {}
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

M.vfn = vim.api.nvim_call_function -- alias to get vim paths

function M.contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

function M.get_module(mod)
  local ok, ts = pcall(require, mod)
  if not ok then
    error('Plugin \'' .. mod .. '\'not installed:\n' .. ts)
  end
  return ts
end

-- Array for exported functions which are mapped to a key
M.fn = {}
M.fns = 1

--- Maps a mapping object ({ mode, bind, opts, fn|cmd }) to a key in vim
-- @param map The mapping object
-- @return If the mapping was successfull
function M.map(map)
  -- Input data check
  if map == nil or map.mode == nil or map.bind == nil or (map.fn == nil and map.cmd == nil) then
    return false
  end

  local options = { noremap = false }
  if map.opts then
    options = vim.tbl_extend('force', options, opts)
  end

  local cmd = map.cmd
  -- Always prefer a function to a cmd
  if map.fn ~= nil then
    table.insert(M.fn, map.fn)
    cmd = '<cmd>lua require\'visimp.utils\'.fn[' .. M.fns .. ']()<CR>'
    M.fns = M.fns + 1
  end

  vim.api.nvim_set_keymap(map.mode, map.bind, cmd, options)
end

return M
