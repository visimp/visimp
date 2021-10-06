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

return M
