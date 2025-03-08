local L = require('visimp.language').new_language 'agda'
local bind = require('visimp.bind').bind
local layer = require 'visimp.layer'

---Constructs callbacks that simply invoke the specified vim command
---@param command string Vim command to invoke (w/o the colon prefix)
---@return function cb The constructed callback
local function vim_cmd_cb(command)
  return function()
    vim.cmd(command)
  end
end

L.default_config = {
  --Settings for the cornelis plugin (https://github.com/isovector/cornelis).
  --The value of each field X will be treated as a value for the global
  --vimscript variable vim.g.cornelis_X.
  cornelis = {},
  binds = {
    [{
      mode = 'n',
      bind = '<leader>al',
      opts = {
        desc = 'Agda: Load and type-check buffer',
      },
    }] = vim_cmd_cb 'CornelisLoad',
    [{
      mode = 'n',
      bind = '<leader>ar',
      opts = {
        desc = 'Agda: Refine goal',
      },
    }] = vim_cmd_cb 'CornelisRefine',
    [{
      mode = 'n',
      bind = '<leader>ad',
      opts = {
        desc = 'Agda: Case split',
      },
    }] = vim_cmd_cb 'CornelisMakeCase',
    [{
      mode = 'n',
      bind = '<leader>a,',
      opts = {
        desc = 'Agda: Show Goal type and context',
      },
    }] = vim_cmd_cb 'CornelisTypeContext',
    [{
      mode = 'n',
      bind = '<leader>a.',
      opts = {
        desc = 'Agda: Show inferred type of hole contents',
      },
    }] = vim_cmd_cb 'CornelisTypeContextInfer',
    [{
      mode = 'n',
      bind = '<leader>an',
      opts = {
        desc = 'Agda: Solve constraints',
      },
    }] = vim_cmd_cb 'CornelisSolve',
    [{
      mode = 'n',
      bind = '<leader>aa',
      opts = {
        desc = 'Agda: Automatic proof search',
      },
    }] = vim_cmd_cb 'CornelisAuto',
    [{
      mode = 'n',
      bind = '<leader>ag',
      opts = {
        desc = 'Agda: Jump to definition of name at cursor',
      },
    }] = vim_cmd_cb 'CornelisGoToDefinition',
    [{
      mode = 'n',
      bind = '[/',
      opts = {
        desc = 'Agda: Jump to previous goal',
      },
    }] = vim_cmd_cb 'CornelisPrevGoal',
    [{
      mode = 'n',
      bind = ']/',
      opts = {
        desc = 'Agda: Jump to next goal',
      },
    }] = vim_cmd_cb 'CornelisNextGoal',
    [{
      mode = 'n',
      bind = '<C-A>',
      opts = {
        desc = 'Agda: <C-A> (also sub-/superscripts)',
      },
    }] = vim_cmd_cb 'CornelisInc',
    [{
      mode = 'n',
      bind = '<C-X>',
      opts = {
        desc = 'Agda: <C-X> (also sub-/superscripts)',
      },
    }] = vim_cmd_cb 'CornelisDec',
  },
}

function L.packages()
  return {
    'kana/vim-textobj-user',
    'neovimhaskell/nvim-hs.vim',
    -- requires running "stack build" after install: see
    -- https://github.com/isovector/cornelis#installation
    'isovector/cornelis',
  }
end

---Adds all the Agda-specific bindings specified in this layer's config.
local function add_agda_bindings()
  bind(L.config.binds)
end

---Adds Agda-specific autocommands to be triggered when using (literate) Agda
---files.
local function create_autocommands()
  local patterns = {
    '*.agda',
    -- https://agda.readthedocs.io/en/latest/tools/literate-programming.html
    '*.lagda',
    '*.lagda.tex',
    '*.lagda.rst',
    '*.lagda.md',
    '*.lagda.typ',
    '*.lagda.org',
    '*.lagda.tree',
  }
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = patterns,
    callback = add_agda_bindings,
  })
  vim.api.nvim_create_autocmd({ 'QuitPre' }, {
    pattern = patterns,
    command = 'CorneliusCloseInfoWindows',
  })
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = patterns,
    command = 'CornelisLoad',
  })
  vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    pattern = patterns,
    callback = function()
      if vim.fn.exists 'CornelisLoad' then
        -- From https://github.com/isovector/cornelis#example-configuration:
        -- "this won't work on the first Agda file you open due to a bug"
        vim.cmd 'silent! CornelisLoad'
      end
    end,
  })
end

function L.load()
  layer.to_vimscript_config(L, 'cornelis_', true, 'cornelis')
  create_autocommands()
end

function L.grammars()
  return { 'agda' }
end

function L.server()
  return 'agda_ls'
end

return L
