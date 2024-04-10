local L = require('visimp.language').new_language 'prolog'

function L.packages()
  return { 'XVilka/prolog-vim' }
end

function L.filetypes()
  return {
    extension = {
      pl = 'prolog',
      pro = 'prolog',
      P = 'prolog',
    },
  }
end

--[[ TODO: https://github.com/mason-org/mason-registry/pull/4011 10-04-24,
-- Stefano Volpe foxy@teapot.ovh ]]
-- function L.server()
--   return 'prolog-language-server'
-- end

function L.load()
  vim.cmd 'packadd prolog-vim'
end

return L
