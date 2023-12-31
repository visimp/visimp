local L = require('visimp.layer').new_layer('snippet')
local loader = require('visimp.loader')
local get_module = require('visimp.bridge').get_module
local bind = require('visimp.bind')

L.default_config = {
  -- LuaSnip setup config
  setup = nil,
  -- A table for loaders (keys are loader names, values are loaders configs)
  loaders = nil,
}

function L.dependencies()
  return { 'cmp' }
end

function L.packages()
  return {
    'l3mon4d3/luasnip',
    'saadparwaiz1/cmp_luasnip',
  }
end

local function process_loader(snippets_loader, config)
  local available_loaders = { 'lua', 'snipmate', 'vscode' }
  for _, available_loader in pairs(available_loaders) do
    if available_loader == snippets_loader then
      require('luasnip.loaders.from_' .. snippets_loader).lazy_load(config)
      return
    end
  end
  error('"snippet" layer: unknown "' .. snippets_loader .. '" loader.')
end

local function load_snippets(loaders)
  for snippets_loader, config in pairs(loaders) do
    process_loader(snippets_loader, config)
  end
end

local function jump(ls, offset)
  return function()
    ls.jump(offset)
  end
end

local function change_choice(ls)
  return function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end
end

local function luasnip_bindings(ls)
  bind.map({ mode = 'i', bind = '<Tab>' }, ls.expand)
  bind.map({ mode = { 'i', 's' }, bind = '<Tab>' }, jump(ls, 1))
  bind.map({ mode = { 'i', 's' }, bind = '<S-Tab>' }, jump(ls, -1))
  bind.map({ mode = { 'i', 's' }, bind = '<C-E>' }, change_choice(ls))
end

local function luasnip_setup()
  local luasnip = get_module('luasnip')
  local config = L.config
  if config.setup then
    luasnip.setup(config.setup)
  end
  if config.loaders then
    load_snippets(config.loaders)
  end
  luasnip_bindings(luasnip)
end

-- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

function L.preload()
  -- Configure the completion layer
  local cmp_layer = loader.get('cmp')

  if
    cmp_layer.config.mapping['<Tab>']
    == cmp_layer.default_config.mapping['<Tab>']
  then
    cmp_layer.config.mapping['<Tab>'] = function(cmp)
      return cmp.mapping(function(fallback)
        local luasnip = get_module('luasnip')
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
      })
    end
  end

  if
    cmp_layer.config.mapping['<S-Tab>']
    == cmp_layer.default_config.mapping['<S-Tab>']
  then
    cmp_layer.config.mapping['<S-Tab>'] = function(cmp)
      return cmp.mapping(function(fallback)
        local luasnip = get_module('luasnip')
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      })
    end
  end

  cmp_layer.add_source({ name = 'luasnip' })
  cmp_layer.set_snippet({
    expand = function(args)
      get_module('luasnip').lsp_expand(args.body)
    end,
  })
  luasnip_setup()
end

function L.add_snippets(filetype, snippets, opts)
  get_module('luasnip').add_snippets(filetype, snippets, opts)
end

return L
