local L = require('layer').new_layer('defaults')

L.default_config = {
  tab_space = 2
}

function L.configure(cfg)
  L.config = cfg
end

function L.on_load()
  -- TODO: use L.config.tab_space
end

return L
