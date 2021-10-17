local M = {
  -- Configuration for the popup floating window
  config = {
    width = 0.8,
    height = 0.7
  },
  -- The current buffer of the floating window
  buf = nil,
  -- The current floating window pointer
  win = nil
}

function M.open()
  local width, height = math.floor(vim.o.columns * M.config.width),
                        math.floor(vim.o.lines * M.config.height)
  local row, col = math.floor( ((vim.o.lines - height)/2) - 1 ),
                   math.floor( (vim.o.columns - width)/2 )

  local cfg = {
    relative = 'editor',
    border = 'single',
    style = 'minimal',
    row = row,
    col = col,
    width = width,
    height = height
  }
  M.buf = vim.api.nvim_create_buf(false, true)
  M.win = vim.api.nvim_open_win(M.buf, true, cfg)

  vim.api.nvim_win_set_option(M.win, 'winhl', 'FloatBorder:FloatBorder')
  vim.api.nvim_win_set_option(M.win, 'winhl', 'Normal:Normal')
end

function M.close()
  vim.api.nvim_win_close(M.win, true)
  vim.api.nvim_buf_delete(M.buf, { force = true })
end

function M.set_content(str)
  vim.api.nvim_buf_set_lines(M.buf, 0, 1, true, str)
end

function M.lock()
  vim.api.nvim_buf_set_option(M.buf, 'modifiable', false)
end

function M.unlock()
  vim.api.nvim_buf_set_option(M.buf, 'modifiable', false)
end

return M
