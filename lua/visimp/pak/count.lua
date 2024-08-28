local window = require 'visimp.pak.window'
local M = {
  packages = {},
  longest_word = 2,
  per_line = 1,
  space_between = 0,
  status = '',
}

---Finds the longest key among all package names
local function find_longest_key()
  local keys = vim.tbl_keys(M.packages)
  table.sort(keys, function(a, b)
    return #a > #b
  end)
  if #keys == 0 then
    M.longest_word = window.width
  else
    M.longest_word = math.min(#keys[1] + 2, window.width)
  end
end

---Computes the amount of lines and spacing between package names
local function recompute_lines()
  M.per_line = math.ceil(math.floor(window.width * 0.8) / (M.longest_word * 2))
  M.space_between = math.ceil(
    (window.width - 2 - (M.longest_word * M.per_line)) / (M.per_line + 1)
  )
end

---Updates the given package in the current buffer view
---@param package string The package key
---@param value string The new char value for the given package
function M.update(package, value)
  M.packages[package] = value
  if #package > M.longest_word then
    M.longest_word = #package
    recompute_lines()
  end
  M.display()
end

---Updates the whole buffer view with a table of new/updates packages
---@param tbl table[] The table of (packages, values)
function M.updates(tbl)
  M.packages = vim.tbl_extend('force', M.packages, tbl)
  find_longest_key()
  recompute_lines()
  M.display()
end

---Adds padding to the right of a string
local function rpad(str, len)
  return str .. string.rep(' ', len - #str)
end

---Sets the bottom line to the given status string
---@param str string The status string
function M.set_status(str)
  M.status = str
  M.display()
end

---Triggers a redraw on the whole window buffer
function M.display()
  table.sort(M.packages)
  local strs = {}
  local str = string.rep(' ', M.space_between)
  for i, k in ipairs(vim.tbl_keys(M.packages)) do
    if (i - 1) % M.per_line == 0 and #str ~= 0 then
      table.insert(strs, str)
      str = string.rep(' ', M.space_between)
    end
    local sp = i % M.per_line ~= 0
    str = str
      .. rpad(M.packages[k] .. ' ' .. k, sp and M.longest_word or 0)
      .. string.rep(' ', M.space_between)
  end
  table.insert(strs, '')
  table.insert(
    strs,
    string.rep(' ', math.ceil((window.width - #M.status) / 2)) .. M.status
  )
  window.set_content(strs)
end

return M
