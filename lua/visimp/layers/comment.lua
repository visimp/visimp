local L = require('visimp.layer').new_layer('comment')
local get_module = require('visimp.utils').get_module

L.default_config = {
  -- Set to true to enable commands provided by the nvim-comment plugin
  commands = false,
  config = {}
}

function L.packages()
  return {'terrortylor/nvim-comment'}
end

function L.load()
  if L.config.commands then
    vim.cmd('packadd nvim-comment')
  end

  local comment = get_module('nvim_comment')
  comment.setup(L.config.config or {})
end

return L
