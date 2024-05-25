local L = require('visimp.layer').new_layer 'blankline'
local get_module = require('visimp.bridge').get_module
local layers = require('visimp.loader').layers

L.default_config = {
  -- Any config from
  -- https://github.com/lukas-reineke/indent-blankline.nvim#setup is a valid
  -- value here
  indent_blankline = {
    scope = {},
  },
  -- Set to false-ish value to disable the rainbow integration even when the
  -- rainbow layer is enabled
  rainbow_integration = {
    {
      name = 'RainbowRed',
      fg = '#E06C75',
    },
    {
      name = 'RainbowYellow',
      fg = '#E5C07B',
    },
    {
      name = 'RainbowBlue',
      fg = '#61AFEF',
    },
    {
      name = 'RainbowOrange',
      fg = '#D19A66',
    },
    {
      name = 'RainbowGreen',
      fg = '#98C379',
    },
    {
      name = 'RainbowViolet',
      fg = '#C678DD',
    },
    {
      name = 'RainbowCyan',
      fg = '#56B6C2',
    },
  },
}

function L.packages()
  return { 'lukas-reineke/indent-blankline.nvim' }
end

--- Adds integration with the rainbow layer according to:
--- https://github.com/lukas-reineke/indent-blankline.nvim?tab=readme-ov-file
--- #rainbow-delimitersnvim-integration
--- @param config table Current layer config
local function add_rainbow_integration(config)
  local highlight = vim.tbl_map(function(v)
    return v.name
  end, config.rainbow_integration)
  local hooks = get_module 'ibl.hooks'
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for _, value in pairs(config.rainbow_integration) do
      vim.api.nvim_set_hl(0, value.name, { fg = value.fg })
    end
  end)
  vim.g.rainbow_delimiters.highlight = highlight
  config.indent_blankline.scope.highlight = highlight
  hooks.register(
    hooks.type.SCOPE_HIGHLIGHT,
    hooks.builtin.scope_highlight_from_extmark
  )
end

function L.load()
  local config = L.config
  if config.rainbow_integration and layers.rainbow ~= nil then
    add_rainbow_integration(config)
  end
  get_module('ibl').setup(config.indent_blankline or {})
end

return L
