local L = require('visimp.layer').new_layer 'ampl'

function L.preload()
  -- Let vim recognize .mod files as AMPL
  vim.cmd 'au! BufRead,BufNewFile *.mod setfiletype ampl'
end

return L
