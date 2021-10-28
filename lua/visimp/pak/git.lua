local init = require('visimp.pak.init')
local count = require('visimp.pak.count')
local window = require('visimp.pak.window')
local M = {}
local uv = vim.loop

--- Returns the git hash of the repository at the given path
-- @param dir string The git directory
-- @return string The git hash
local function get_git_hash(dir)
  local first_line = function(path)
    local file = io.open(path)
    if file then
      local line = file:read()
      file:close()
      return line
    end
  end
  local head_ref = first_line(dir .. '/.git/HEAD')
  return head_ref and first_line(dir .. '/.git/' .. head_ref:gsub('ref: ', ''))
end

--- Calls the given process in a shell
-- @param process string The process command
-- @param args list A list of arguments to set as argv
-- @param cwd string The working directory of the spawned process
-- @param cb function A function to be run as a callback upon process exit
-- (with an argument set to true if exit code was equal to zero, false
-- otherwhise)
local function call_proc(process, args, cwd, cb)
  local log, stderr, handle
  log = uv.fs_open(init.logfile, 'a+', 0x1A4)
  stderr = uv.new_pipe(false)
  stderr:open(log)
  handle = uv.spawn(
    process,
    {
      args = args,
      cwd = cwd,
      stdio = { nil, nil, stderr },
      env = { 'GIT_TERMINAL_PROMPT=0' },
    },
    vim.schedule_wrap(function(code)
      uv.fs_close(log)
      stderr:close()
      handle:close()
      cb(code == 0)
    end)
  )
end

--- Installs all registered packages
-- @param cb A callback which is called after the installation has completed
function M.install(cb)
  init.fill()
  for _, pkg in pairs(init.packages) do
    if pkg.exists then
      init.update(pkg.name, 'v')
    else
      local args = {
        'clone',
        pkg.url,
        '--depth=1',
        '--recurse-submodules',
        '--shallow-submodules',
      }
      if pkg.branch then
        vim.list_extend(args, { '-b', pkg.branch })
      end
      vim.list_extend(args, { pkg.dir })
      local count = 0
      call_proc('git', args, nil, function(ok)
        if ok then
          pkg.exists = true
          init.update(pkg.name, 'v')
        else
          init.update(pkg.name, 'x')
        end

        count = count + 1
        if cb ~= nil and count == #init.packages then
          cb()
        end
      end)
    end
  end
end

--- Updates all registered packages
function M.update()
  init.fill()
  for _, pkg in pairs(init.packages) do
    if not pkg.exists or pkg.pin then
      init.update(pkg.name, 'x')
    end
    local hash = get_git_hash(pkg.dir)
    local post_update = function(ok)
      if get_git_hash(pkg.dir) ~= hash then
        init.update(pkg.name, 'u')
      else
        init.update(pkg.name, 'v')
      end
    end
    call_proc(
      'git',
      { 'pull', '--recurse-submodules', '--update-shallow' },
      pkg.dir,
      post_update
    )
  end
end

--- Removes all unregistered packages in the given directory
-- @param packdir string The directory to look for unregistered packages
function M.remove(packdir)
  local name, dir, pkg
  local to_rm = {}
  local c = 0
  local handle = uv.fs_scandir(packdir)
  while handle do
    name = uv.fs_scandir_next(handle)
    if not name then
      break
    end
    pkg = init.packages[name]
    dir = packdir .. name
    if not (pkg and pkg.dir == dir) then
      to_rm[name] = dir
      c = c + 1
    end
  end
  for name, dir in pairs(to_rm) do
    if name ~= 'vismp' then
      init.packages[name] = nil
      local ok = vim.fn.delete(dir, 'rf')
      init.update(name, ok and 'x' or 'X')
    end
  end
end

--- Cleans all unregistered packages in all runtime directories
function M.clean()
  init.fill()
  M.remove(init.pakdir .. 'start/')
  M.remove(init.pakdir .. 'opt/')
end

return M
