local M = {
  -- Configuration for the popup floating window
  config = {
    width = 0.8,
    height = 0.7
  },
  -- The current buffer of the floating window
  buf = nil,
  buflen = 1,
  -- The current floating window pointer
  win = nil,
}

function M.init()
  M.width = math.ceil(vim.o.columns * M.config.width)
  M.height = math.ceil(vim.o.lines * M.config.height)
end

function M.open()
  local row, col = math.ceil( ((vim.o.lines - M.height)/2) - 1 ),
                   math.ceil( (vim.o.columns - M.width)/2 )

  local cfg = {
    relative = 'editor',
    border = 'single',
    style = 'minimal',
    row = row,
    col = col,
    width = M.width,
    height = M.height
  }
  M.buf = vim.api.nvim_create_buf(false, true)
  M.buflen = 1
  M.win = vim.api.nvim_open_win(M.buf, true, cfg)

  vim.api.nvim_win_set_option(M.win, 'winhl', 'FloatBorder:FloatBorder')
  vim.api.nvim_win_set_option(M.win, 'winhl', 'Normal:Normal')
end

function M.close()
  vim.api.nvim_win_close(M.win, true)
  vim.api.nvim_buf_delete(M.buf, { force = true })
end

function M.set_content(str)
  vim.api.nvim_buf_set_lines(M.buf, 0, M.buflen, true, str)
  M.buflen = #str
end

function M.set_line(line, str)
  vim.api.nvim_buf_set_lines(M.buf, line, line, true, str)
end

function M.set_lines(start, _end, str)
  vim.api.nvim_buf_set_lines(M.buf, start, _end, true, str)
end

function M.lock()
  vim.api.nvim_buf_set_option(M.buf, 'modifiable', false)
end

function M.unlock()
  vim.api.nvim_buf_set_option(M.buf, 'modifiable', false)
end

return M
