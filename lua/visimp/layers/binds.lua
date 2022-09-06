local L = require('visimp.layer').new_layer('binds')

L.default_config = {}

function L.load()
  require('visimp.bind').bind(L.config, nil)
end

return L
