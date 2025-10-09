local L = require('visimp.language'):new_language 'python'

function L.grammars()
  return { 'python' }
end

function L.server()
  -- Using 'basedpyright' instead of 'pyright' here
  -- provides a more modern and feature right fork.
  -- Also allows us to drop the dependency on node for working with python.
  -- (pyright with mason is installed using nodejs for some reason).
  return 'basedpyright'
end

return L
