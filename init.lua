require'visimp'{
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
    'c', 'python', 'latex'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
  -- theme = gruvbox()
  theme = {'lifepillar/vim-gruvbox8', 'gruvbox8', 'dark'}
}
