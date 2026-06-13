local L = require('visimp.layer'):new_layer 'ltex'
local layers = require 'visimp.loader'

---Optional configuration to be provided for the language server
---All fields from
---https://github.com/neovim/nvim-lspconfig/blob/master/doc/
---server_configurations.md#ltex are accepted here.
L.default_config = {
  language = 'en-US',
}

function L.dependencies()
  return { 'lsp' }
end

function L.preload()
  -- If the user has provided a config, we wrap it
  -- into the ltex config
  local cfg = L.config and { ltex = L.config } or {}
  layers
    .get('lsp') --[[@as LspLayer]]
    :use_server('ltex', true, 'ltex_plus', cfg)
end

return L
