local L = require('visimp.layer').new_layer('binds')
local bind = require('visimp.bind').bind

L.default_config = {
}

function L.load()
  bind(L.config, function(action)
    if type(action) == 'string' then
      return function() vim.api.nvim_command(action) end
    elseif type(action) == 'function' then
      return action
    else
      error('Invalid bind handler type:', type(action))
      return nil
    end
  end)
end

return L
