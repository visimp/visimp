local git = require 'visimp.pak.git'
local logic = require 'visimp.pak.logic'
local window = require 'visimp.pak.window'

---visimp's in-house plugin manager
local M = {
  register = logic.register,
  any_missing = logic.any_missing,
  list = logic.list,
  install = git.install,
  update = git.update,
  clean = git.clean,
}

---Runs a package manager command setting up the visual menu
---@param cmd string The method name
function M.run(cmd)
  window.init()
  window.open()
  if M[cmd] ~= nil then
    M[cmd]()
  else
    error('Invalid pak call: ' .. cmd)
  end
end

do
  --- vim.cmd's annotated type is misleading
  ---@diagnostic disable-next-line:param-type-mismatch
  vim.tbl_map(vim.cmd, {
    'command! PakInstall  lua require(\'visimp.pak\').run(\'install\')',
    'command! PakUpdate   lua require(\'visimp.pak\').run(\'update\')',
    'command! PakClean    lua require(\'visimp.pak\').run(\'clean\')',
    'command! PakList     lua require(\'visimp.pak\').run(\'list\')',
  })
end

return M
