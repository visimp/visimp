local M = {}

M.unloaded = 'l'
M.loaded = 'L'
M.loading = '~'

--- Returns an empty new layer for the given identifier
-- @param id A string used as the layer identifier
-- @return layer The newly created layer
function M.new_layer(id)
  local layer = {
    identifier = id,
    loading_status = M.unloaded,
    depends_on = {},

    on_load = function() end
  }
  return layer
end

return M
