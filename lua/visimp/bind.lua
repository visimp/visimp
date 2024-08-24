---Utilites for binding vi keys to actions
---@module visimp.bind Bind
local M = {
  registered = {},
}

---Checks if a bind object is correct
---@param bind table The bind object
---@return boolean result True if the bind is _valid_, false otherwhise
function M.is_valid(bind)
  return bind ~= nil and bind.mode ~= nil and bind.bind ~= nil
end

---Maps a mapping object ({ mode, bind, opts }) to a function in lua
---Assumes valid input data
---@param map table The mapping object
---@param fn function The call handler
function M.map(map, fn)
  local options = { noremap = false, silent = true }
  if map.opts then
    options = vim.tbl_extend('force', options, map.opts)
  end

  table.insert(M.registered, map)
  vim.keymap.set(map.mode, map.bind, fn, options)
end

---Returns the list of registered keymaps
---This can be used by layers to act upon registered custom binds
---@return table[] binds The list of registered keymap structures (the
---right-hand-side of a bind assignment)
function M.get_registered()
  return M.registered
end

---Sets the buffer of the given key.
---@param key table A key object for a bind.
---@param buffer integer|nil A buffer number, or nil if the bind is meant to be
---global.
local function set_buffer(key, buffer)
  if not buffer then
    return
  end
  if not key.opts then
    key.opts = {}
  end
  key.opts.buffer = buffer
end

---Sets up the list of binds with the given list/function of handlers
---@param binds table[] The list of binds in a correct format
---@param handler table[]|function Either a table of bind actions of a function
---for manually assigning a bind function to a key
---@param buffer integer|nil A buffer identifier if all binds want to be
---registered as local to a certain buffer. Nil otherwhise.
function M.bind(binds, handler, buffer)
  if
    type(handler) ~= 'function'
    and type(handler) ~= 'table'
    and handler ~= nil
  then
    error 'Invalid bind handler: can either be a function or a table or nil'
  end

  for key, exec in pairs(binds) do
    if not M.is_valid(key) then
      error(
        'Invalid key bind: \n'
          .. vim.inspect(key)
          .. ' -> '
          .. vim.inspect(exec)
      )
    end

    local hndlr = handler == nil and exec
      or type(handler) == 'table' and handler[exec]
      or handler(exec)
    set_buffer(key, buffer)
    M.map(key, hndlr)
  end
end

return M
