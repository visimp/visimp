local L = require('visimp.layer').new_layer('latex')
local layers = require('visimp.loader')

-- TODO: add latex language server
L.default_config = {
  -- Install and enable the vimtex plugin
  vimtex = true
}

function L.dependencies()
  return {'treesitter'}
end

function L.preload()
  -- Configure treesitter
  local ts = layers.get('treesitter')
  ts.langs({'latex'})

  if L.config.vimtex then
    package('lervag/vimtex')
    vim.cmd('packadd vimtex')
  end
end
