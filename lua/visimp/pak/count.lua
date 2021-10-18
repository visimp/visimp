local window = require('visimp.pak.window')
local M = {
  packages = {},
  longest_word = 2,
  per_line = 1,
  space_between = 0
}

local function find_longest_key()
  local keys = vim.tbl_keys(M.packages)
  table.sort(keys, function(a,b) return #a>#b end)
  if #keys == 0 then
    M.longest_word = window.width
  else
    M.longest_word = math.min(#keys[1] + 2, window.width)
  end
end

local function recompute_lines()
  M.per_line = math.min(math.ceil(window.width / M.longest_word), 4)
  M.space_between = math.ceil((window.width - 2 - (M.longest_word * M.per_line)) / (M.per_line-1))
end

function M.update(package, value)
  M.packages[package] = value
  if(#package > M.longest_word) then
    M.longest_word = #package
    recompute_lines()
  end
  M.display()
end

function M.updates(tbl)
  M.packages = vim.tbl_extend('force', M.packages, tbl) find_longest_key()
  recompute_lines()
  M.display()
end

local function rpad(str, len)
  return str .. string.rep(' ', len - #str)
end

--- Triggers a redraw on the whole window buffer
function M.display()
  table.sort(M.packages)
  local strs = {}
  local str = ''
  for i, k in ipairs(vim.tbl_keys(M.packages)) do
    if (i-1) % M.per_line == 0 and #str ~= 0 then
      table.insert(strs, str)
      str = ''
    end
    local sp = i % M.per_line ~= 0
    str = str .. rpad(M.packages[k] .. ' ' .. k, sp and M.longest_word or 0) ..
      (sp and string.rep(' ', M.space_between) or '')
  end
  window.set_content(strs)
end

return M
