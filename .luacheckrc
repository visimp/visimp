return {
  max_code_line_length = 80,
  max_line_length = 80,
  globals = {
    'vim',
  },
  std = 'lua51c',
  ignore = {
    '212/self', -- base classes usually provide mock implementations
  },
}
