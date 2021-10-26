local M = {
  -- Array for exported functions which are mapped to a key
  fn = {},
  fns = 1,
}

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

M.vfn = vim.api.nvim_call_function -- alias to get vim paths

function M.get_module(mod)
  local ok, ts = pcall(require, mod)
  if not ok then
    error('Plugin \'' .. mod .. '\'not installed:\n' .. ts)
  end
  return ts
end

--- Maps a lua function to a vimscript call
-- @param fn A lua function
-- @return The vimscript call to execute the function
function M.vimfn(fn)
  table.insert(M.fn, fn)
  cmd = 'lua require\'visimp.utils\'.fn[' .. M.fns .. ']()'
  M.fns = M.fns + 1
  return cmd
end

return M
