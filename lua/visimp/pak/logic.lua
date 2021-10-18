local init = require('visimp.pak.init')
local count = require('visimp.pak.count')
local window = require('visimp.pak.window')
local M = {}

function M.list()
  local keys = vim.tbl_keys(init.packages)
  table.sort(keys)
  local pkgs = {}
  for _, k in ipairs(keys) do
    pkgs[k] = init.sym_tbl[k] or ' '
  end

  count.updates(pkgs)
  window.lock()
end

function M.register(args)
  if type(args) == "string" then args = {args} end
  local name, src
  if args.as then
    name = args.as
  elseif args.url then
    name = args.url:gsub("%.git$", ""):match("/([%w-_.]+)$")
    src = args.url
  else
    name = args[1]:match("^[%w-]+/([%w-_.]+)$")
    src = args[1]
  end
  if not name then
    error("Invalid package source: " .. src)
  elseif init.packages[name] then
    return
  end

  local dir = init.pakdir .. (args.opt and "opt/" or "start/") .. name

  init.packages[name] = {
    name = name,
    branch = args.branch,
    dir = dir,
    exists = vim.fn.isdirectory(dir) ~= 0,
    pin = args.pin,
    url = args.url or "https://github.com/" .. args[1] .. ".git"
  }
end

return M
