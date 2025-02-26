local L = require('visimp.layer').new_layer 'typos'
local layers = require 'visimp.loader'

---Typos is to be configured via its own config files.
L.default_config = {}

function L.dependencies()
  return { 'lsp' }
end

function L.preload()
  layers.get('lsp').use_server('typos', true, 'typos_lsp', {})
end

return L
