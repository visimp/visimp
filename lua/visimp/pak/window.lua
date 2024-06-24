--- The visimp package manager's popup manager
-- @module visimp.pak.window
local M = {
  -- Configuration for the popup floating window
  config = {
    width = 0.8,
    height = 0.7,
  },
  -- The current buffer of the floating window
  buf = nil,
  buflen = 1,
  -- The current floating window pointer
  win = nil,

  title = 'Package Management',
}

--- Initializes the window module relative to the size of the vi window
function M.init()
  M.width = math.ceil(vim.o.columns * M.config.width)
  M.height = math.ceil(vim.o.lines * M.config.height)
end

--- Opens the floating window and relative buffer
function M.open()
  local row, col =
    math.ceil(((vim.o.lines - M.height) / 2) - 1),
    math.ceil((vim.o.columns - M.width) / 2)

  local cfg = {
    relative = 'editor',
    border = 'single',
    style = 'minimal',
    row = row,
    col = col,
    width = M.width,
    height = M.height,
  }
  M.buf = vim.api.nvim_create_buf(false, true)
  M.buflen = 1
  M.win = vim.api.nvim_open_win(M.buf, true, cfg)

  vim.api.nvim_set_option_value(
    'winhl',
    'FloatBorder:FloatBorder',
    { win = M.win }
  )
  vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = M.win })
end

--- Closes the floating window
function M.close()
  vim.api.nvim_win_close(M.win, true)
  vim.api.nvim_buf_delete(M.buf, { force = true })
end

--- Updates the whole content to the given list of strings
-- @param str A list of strings
function M.set_content(str)
  local content = {
    string.rep(' ', math.ceil((M.width - #M.title) / 2)) .. M.title,
    '',
  }
  vim.list_extend(content, str)
  vim.api.nvim_buf_set_lines(M.buf, 0, M.buflen, true, content)
  M.buflen = #content
end

--- Updates the given single line with the provided new one
-- @param line The index of the line which needs updating
-- @param str The new line string
function M.set_line(line, str)
  vim.api.nvim_buf_set_lines(M.buf, line, line, true, str)
end

--- Sets the title of the dialog
-- @param str The title string
function M.set_title(str)
  M.title = str
end

--- Updates a list of lines between start and end
-- @param start The start of the replacement
-- @param end_ The end of the replacement
-- @param str The list of strings which will serve as a replacement
function M.set_lines(start, end_, str)
  vim.api.nvim_buf_set_lines(M.buf, start + 2, end_ + 2, true, str)
end

--- Locks the floating window buffer
function M.lock()
  vim.api.nvim_set_option_value('modifiable', false, { buf = M.buf })
end

--- Unlocks the floating window buffer
function M.unlock()
  vim.api.nvim_set_option_value('modifiable', false, { buf = M.buf })
end

return M
