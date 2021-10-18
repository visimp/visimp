local init = require('visimp.pak.init')
local count = require('visimp.pak.count')
local window = require('visimp.pak.window')
local M = {}
local uv = vim.loop

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

local function call_proc(process, args, cwd, cb)
    local log, stderr, handle
    log = uv.fs_open(init.logfile, "a+", 0x1A4)
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

function M.install()
  init.fill()
  for _, pkg in pairs(init.packages) do
    if pkg.exists then
      init.update(pkg.name, true)
    else
      local args = {"clone", pkg.url, "--depth=1", "--recurse-submodules", "--shallow-submodules"}
      if pkg.branch then vim.list_extend(args, {"-b", pkg.branch}) end
      vim.list_extend(args, {pkg.dir})
      call_proc("git", args, nil, function(ok)
        if ok then
          pkg.exists = true
          if pkg.run then run_hook(pkg) end
          init.update(pkg.name, true)
        else
          init.update(pkg.name, false)
        end
      end)
    end
  end
end

function M.update()
  init.fill()
  for _, pkg in pairs(init.packages) do
    if not pkg.exists or pkg.pin then
      init.update(pkg.name, true)
    end
    local hash = get_git_hash(pkg.dir)
    local post_update = function(ok)
      if get_git_hash(pkg.dir) ~= hash then
        last_ops[pkg.name] = "update"
        if pkg.run then run_hook(pkg) end
      end
      init.update(pkg.name, ok)
    end
    call_proc("git", {"pull", "--recurse-submodules", "--update-shallow"}, pkg.dir, post_update)
  end
end

return M
