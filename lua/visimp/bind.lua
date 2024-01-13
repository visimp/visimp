--- Utilites for binding vi keys to actions
-- @module visimp.bind
local M = {
  registered = {},
}

--- Checks if a bind object is correct
-- @param bind The bind object
-- @return True if the bind is _valid_, false otherwhise
function M.is_valid(bind)
  return bind ~= nil and bind.mode ~= nil and bind.bind ~= nil
end

--- Maps a mapping object ({ mode, bind, opts }) to a function in lua
-- Assumes valid input data
-- @param map The mapping object
-- @param fn The call handler
function M.map(map, fn)
  local options = { noremap = false, silent = true }
  if map.opts then
    options = vim.tbl_extend('force', options, map.opts)
  end

  table.insert(M.registered, map)
  vim.keymap.set(map.mode, map.bind, fn, options)
end

--- Returns the list of registered keymaps
-- This can be used by layers to act upon registered custom binds
-- @return The list of registered keymap structures (the right-hand-side of a
--         bind assignment)
function M.get_registered()
  return M.registered
end

--- Sets up the list of binds with the given list/function of handlers
-- @param binds The list of binds in a correct format
-- @param handler Either a table of bind actions of a function for manually
--                assigning a bind function to a key
function M.bind(binds, handler)
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
    M.map(key, hndlr)
  end
end

return M
