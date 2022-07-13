local L = require('visimp.layer').new_layer('autopairs')
local get_module = require('visimp.bridge').get_module

-- All fields from https://github.com/windwp/nvim-autopairs#default-values
-- are accepted here. Extra fields are as follows
L.default_config = {
  cmp_integration = true
  html = true
}

function L.dependecies()
  if L.config.cmp_integration then
    return { 'cmp' }
  end
  return {}
end

function L.packages()
  return { 
    { 'windwp/nvim-autopairs', opt = false },
    { 'windwp/nvim-ts-autotag', opt = true }
  }
end

function L.load()
  get_module('nvim-autopairs').setup(L.config or {})
  if L.config.cmp_integration then
    local cmp_autopairs = get_module('nvim-autopairs.completion.cmp')
    local cmp = get_module('cmp')
    cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
    )
  end
  if L.config.html then
    get_module('nvim-ts-autotag').setup()
  end
end

return L
