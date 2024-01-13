local L = require('visimp.layer').new_layer 'coq'

L.default_config = {}

function L.dependencies()
  return {}
end

function L.packages()
  return {
    'whonore/Coqtail',
  }
end

function L.load()
  vim.cmd 'packadd Coqtail'
end

return L
