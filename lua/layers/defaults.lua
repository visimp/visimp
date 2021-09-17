local layer = require('layer')
local loader = require('loader')
local L = layer.new_layer('defaults')

L.on_load = function()
  print('hello', loader.get('defaults'))
end

return L
