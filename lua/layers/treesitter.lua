local L = require('layer').new_layer('treesitter')

local default_config = {
  highlight = true,
  indent = true,
}

L.config = default_config

function L.configure(cfg)
  L.config = default_config
  cfg = cfg or {}
  for k,v in pairs(cfg) do
    L.config[k] = v
  end
end

function L.packages()
  return {'nvim-treesitter/nvim-treesitter'}
end

function L.load()
  local ok, ts = pcall(require, 'nvim-treesitter.configs')
  if not ok then
    error('TreeSitter not installed:\n' .. ts)
  end

  ts.setup({
    highlight = { enable = L.config.highlight },
    indent = { enable = L.config.indent }
  })
end

return L

