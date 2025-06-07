local L = require('visimp.language'):new_language 'hcl'

L.default_config = {
  ---Whether to use or disable the terraform lsp
  terraform = true,
}

function L.grammars()
  if L.config.terraform then
    return { 'hcl', 'terraform' }
  end
  return { 'hcl' }
end

function L.server()
  return 'terraformls'
end

return L
