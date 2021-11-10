require'visimp'{
  languages = {
    -- 'ampl',
    -- 'bash',
    -- 'c',
    -- 'csharp',
    -- 'css',
    -- 'dart',
    -- 'go',
    -- 'haskell',
    -- 'html',
    -- 'java',
    -- 'javascript',
    -- 'json',
    -- 'latex',
    -- 'lua',
    -- 'php',
    -- 'python',
    -- 'toml'
  },

  -- Any extra layers can be enabled or configured (which implicitly enabled
  -- them) by adding a field in this configuration. Let's say we want to eanble
  -- the `lspsignature` layer, this is what we'd add:
  lspsignature = {},
  --
  -- Layers can also be disabled by setting a key to false
  -- For example the following line disabled the `lspsignature` layer:
  -- lspsignature = false

  --       package url                theme name  background
  --       github username/repo       a string    either dark or bright
  theme = {'lifepillar/vim-gruvbox8', 'gruvbox8', 'dark'}
}
