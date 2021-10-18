-- all credits for the original version to the paq package manager author
-- will later be slimmed down to include just what's needed and no more

local window = require('visimp.pak.window')
local count = require('visimp.pak.count')

local uv = vim.loop
local print_err = vim.api.nvim_err_writeln
local sym_tbl = {install = '+', update = '*', remove = '-'}

local cfg = {
    pakdir = vim.fn.stdpath("data") .. "/site/pack/paks/",
    verbose = true,
}
local LOGFILE = vim.fn.stdpath("cache") .. "/pak.log"
local packages = {} -- 'name' = {options} pairs
local last_ops = {} -- 'name' = 'op' pairs
local counters = {}
local messages = {
    install = {
        ok = "installed %s",
        err = "failed to install %s",
    },
    update = {
        ok = "updated %s",
        err = "failed to update %s",
        nop = "(up-to-date) %s",
    },
    remove = {
        ok = "removed %s",
        err = "failed to remove %s",
    },
    hook = {
        ok = "ran hook for %s",
        err = "failed to run hook for %s",
    }
}
local M = {}

local function Counter(op) counters[op] = {ok=0, err=0, nop=0} end

local function update_count(op, result, _, total)
    local c, t = counters[op]
    if not c then return end
    c[result] = c[result] + 1
    t = c[result]
    if c.ok + c.err + c.nop == total then
        Counter(op)
        vim.cmd("packloadall! | silent! helptags ALL")
    end
    return t
end

local function report(op, result, name, total)
    local total = total or #packages
    local cur = update_count(op, result, nil, total)
    local count = cur and string.format("%d/%d", cur, total) or ""
    local msg = messages[op][result]
    local p = result == "err" and print_err or print
    p(string.format("Pak [%s] " .. msg, count, name))
end

local function call_proc(process, args, cwd, cb)
    local log, stderr, handle
    log = uv.fs_open(LOGFILE, "a+", 0x1A4)
    stderr = uv.new_pipe(false)
    stderr:open(log)
    handle = uv.spawn(
        process,
        {args=args, cwd=cwd, stdio={nil, nil, stderr}, env={"GIT_TERMINAL_PROMPT=0"}},
        vim.schedule_wrap(function(code)
            uv.fs_close(log)
            stderr:close()
            handle:close()
            cb(code == 0)
        end)
    )
end

local function run_hook(pkg)
    local t = type(pkg.run)
    if t == "function" then
        vim.cmd("packadd " .. pkg.name)
        local ok = pcall(pkg.run)
        report("hook", ok and "ok" or "err", pkg.name)
    elseif t == "string" then
        local args = {}
        for word in pkg.run:gmatch("%S+") do
            table.insert(args, word)
        end
        local post_hook = function(ok) report("hook", ok and "ok" or "err", pkg.name) end
        call_proc(table.remove(args, 1), args, pkg.dir, post_hook)
    end
end

local function install_pkg(pkg)
    if pkg.exists then return update_count("install", "nop", nil, #packages) end
    local args = {"clone", pkg.url, "--depth=1", "--recurse-submodules", "--shallow-submodules"}
    if pkg.branch then vim.list_extend(args, {"-b", pkg.branch}) end
    vim.list_extend(args, {pkg.dir})
    local post_install = function(ok)
        if ok then
            pkg.exists = true
            last_ops[pkg.name] = "install"
            if pkg.run then run_hook(pkg) end
        end
        report("install", ok and "ok" or "err", pkg.name)
    end
    call_proc("git", args, nil, post_install)
end

function M.install(pkg)
  Counter "install"
  vim.tbl_map(install_pkg, packages)
end

local function get_git_hash(dir)
    local first_line = function(path)
        local file = io.open(path)
        if file then
            local line = file:read()
            file:close()
            return line
        end
    end
    local head_ref = first_line(dir .. "/.git/HEAD")
    return head_ref and first_line(dir .. "/.git/" .. head_ref:gsub("ref: ", ""))
end

function M.update()
  for _, pkg in pairs(packages) do
    if not pkg.exists or pkg.pin then return update_count("update", "nop", nil, #packages) end
    local hash = get_git_hash(pkg.dir)
    local post_update = function(ok)
      if not ok then
        return report("update", "err", pkg.name)
      elseif get_git_hash(pkg.dir) ~= hash then
        last_ops[pkg.name] = "update"
        report("update", "ok", pkg.name)
        if pkg.run then run_hook(pkg) end
      else
        (cfg.verbose and report or update_count)("update", "nop", pkg.name, #packages) -- blursed
    end
    end
    call_proc("git", {"pull", "--recurse-submodules", "--update-shallow"}, pkg.dir, post_update)
  end
end

local function remove(packdir)
    local name, dir, pkg
    local to_rm = {}
    local c = 0
    local handle = uv.fs_scandir(packdir)
    while handle do
        name = uv.fs_scandir_next(handle)
        if not name then break end
        pkg = packages[name]
        dir = packdir .. name
        if not (pkg and pkg.dir == dir) then
            to_rm[name] = dir
            c = c + 1
        end
    end
    for name, dir in pairs(to_rm) do
        if name ~= 'vismp' then
          packages[name] = nil
          local ok = vim.fn.delete(dir, "rf")
          report("remove", ok == 0 and "ok" or "err", name, c)
        end
    end
end

function M.list()
  local keys = vim.tbl_keys(packages)
  table.sort(keys)
  local pkgs = {}
  for _, k in ipairs(keys) do
    pkgs[k] = sym_tbl[k] or ' '
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
        return print_err("Pak: Failed to parse " .. src)
    elseif packages[name] then
        return
    end

    local dir = cfg.pakdir .. (args.opt and "opt/" or "start/") .. name

    packages[name] = {
        name = name,
        branch = args.branch,
        dir = dir,
        exists = vim.fn.isdirectory(dir) ~= 0,
        pin = args.pin,
        run = args.run,
        url = args.url or "https://github.com/" .. args[1] .. ".git"
    }
end

function M.clean()
  Counter('remove')
  remove(cfg.pakdir .. 'start/')
  remove(cfg.pakdir .. 'opt/')
end

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
  vim.tbl_map(vim.cmd, {
    "command! PakInstall  lua require('visimp.pak').run('install')",
    "command! PakUpdate   lua require('visimp.pak').run('update')",
    "command! PakClean    lua require('visimp.pak').run('clean')",
    "command! PakRunHooks lua require('visimp.pak').run('run_hooks')",
    "command! PakSync     lua require('visimp.pak').run('sync')",
    "command! PakList     lua require('visimp.pak').run('list')",
    "command! PakLogOpen  lua require('visimp.pak').run('log_open')",
    "command! PakLogClean lua require('visimp.pak').run('log_clean')"
  })
end

return M

-- return {
--   register = register,
--   install = function(self) Counter "install" vim.tbl_map(install_pkg, packages) return self end,
--   update = function(self) Counter "update" vim.tbl_map(update, packages) return self end,
--   clean = function(self) Counter "remove" remove(cfg.pakdir .. "start/") remove(cfg.pakdir .. "opt/") return self end,
--   sync = function(self) self:clean():update():install() return self end,
--   run_hooks = function(self) vim.tbl_map(run_hook, packages) return self end,
--   list = list,
--   setup = function(self, args) for k,v in pairs(args) do cfg[k] = v end return self end,
--   log_open = function(self) vim.cmd("sp " .. LOGFILE) return self end,
--   log_clean = function(self) uv.fs_unlink(LOGFILE) print("Paq log file deleted") return self end,
-- }
