--- General utilities to bridge the gap between vimscript and lua
-- @module visimp.bridge
local M = {}

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

M.vfn = vim.api.nvim_call_function -- alias to get vim paths

--- Lua's builtin prequire with default error message for missing packages
---@param mod string The lua module name, inside runtimepath
---@returns any The successful require result
function M.get_module(mod)
  local ok, val = pcall(require, mod)
  if not ok then
    error('Plugin \'' .. mod .. '\'not installed:\n' .. val)
  end
  return val
end

return M
