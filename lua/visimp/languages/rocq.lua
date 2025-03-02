local bind_module = require 'visimp.bind'
local vim_cmd_cb = bind_module.vim_cmd_cb
local bind = bind_module.bind
local layer = require 'visimp.layer'
local L = layer.new_layer 'rocq'

L.default_config = {
  coqtail = {
    nomap = 1,
    noimap = 1,
  },
  -- Coqtail's default mappings start by "<leader>c", so they conflict with
  -- some from the diagnostics layer ("c" stands for code there). Our default
  -- binds change the prefix to "<leader>r" ("r" stands for Rocq).
  binds = {
    [{
      mode = 'n',
      bind = '<leader>rc',
      opts = {
        desc = 'Start Rocq',
      },
    }] = vim_cmd_cb 'CoqStart',
    [{
      mode = 'n',
      bind = '<leader>rq',
      opts = {
        desc = 'Stop Rocq',
      },
    }] = vim_cmd_cb 'CoqStop',
    [{
      mode = 'n',
      bind = '<C-C>',
      opts = {
        desc = 'Interrupt Rocq',
      },
    }] = vim_cmd_cb 'CoqInterrupt',
    [{
      mode = 'n',
      bind = '<leader>rj',
      opts = {
        desc = 'Rocq: check next',
      },
    }] = vim_cmd_cb 'CoqNext',
    [{
      mode = 'n',
      bind = '<leader>rk',
      opts = {
        desc = 'Rocq: rewind previous',
      },
    }] = vim_cmd_cb 'CoqUndo',
    [{
      mode = 'n',
      bind = '<leader>rl',
      opts = {
        desc = 'Rocq: check/rewind up to here',
      },
    }] = vim_cmd_cb 'CoqToLine',
    [{
      mode = 'n',
      bind = '<leader>rT',
      opts = {
        desc = 'Rocq: rewind all',
      },
    }] = vim_cmd_cb 'CoqToTop',
    [{
      mode = 'n',
      bind = '<leader>rG',
      opts = {
        desc = 'Rocq: go to last checked',
      },
    }] = vim_cmd_cb 'CoqJumpToEnd',
    [{
      mode = 'n',
      bind = '<leader>rE',
      opts = {
        desc = 'Rocq: go to error',
      },
    }] = vim_cmd_cb 'CoqJumpToError',
    [{
      mode = 'n',
      bind = '<leader>rgd',
      opts = {
        desc = 'Rocq: go to definition',
      },
    }] = vim_cmd_cb 'CoqGoToDef',
    [{
      mode = 'n',
      bind = '<leader>rs',
      opts = {
        desc = 'Rocq: coq search',
      },
    }] = vim_cmd_cb 'CoqSearch',
    [{
      mode = 'n',
      bind = '<leader>rh',
      opts = {
        desc = 'Rocq: check',
      },
    }] = vim_cmd_cb 'Coq Check',
    [{
      mode = 'n',
      bind = '<leader>ra',
      opts = {
        desc = 'Rocq: about',
      },
    }] = vim_cmd_cb 'Coq About',
    [{
      mode = 'n',
      bind = '<leader>rp',
      opts = {
        desc = 'Rocq: print',
      },
    }] = vim_cmd_cb 'Coq Print',
    [{
      mode = 'n',
      bind = '<leader>rf',
      opts = {
        desc = 'Rocq: locate',
      },
    }] = vim_cmd_cb 'Coq Locate',
    [{
      mode = 'n',
      bind = '<leader>rr',
      opts = {
        desc = 'Rocq: restore panels',
      },
    }] = vim_cmd_cb 'CoqRestorePanels',
    [{
      mode = 'n',
      bind = '<leader>rgg',
      opts = {
        desc = 'Rocq: go to goal start',
      },
    }] = vim_cmd_cb 'CoqGotoGoal',
    [{
      mode = 'n',
      bind = '<leader>rgG',
      opts = {
        desc = 'Rocq: go to goal end',
      },
    }] = vim_cmd_cb 'CoqGoToGoal!',
    [{
      mode = 'n',
      bind = ']g',
      opts = {
        desc = 'Rocq: go to next goal start',
      },
    }] = vim_cmd_cb 'CoqGotoGoalNext',
    [{
      mode = 'n',
      bind = ']G',
      opts = {
        desc = 'Rocq: go to next goal end',
      },
    }] = vim_cmd_cb 'CoqGotoGoalNext!',
    [{
      mode = 'n',
      bind = '[g',
      opts = {
        desc = 'Rocq: go to previous goal start',
      },
    }] = vim_cmd_cb 'CoqGotoGoalPrev',
    [{
      mode = 'n',
      bind = '[G',
      opts = {
        desc = 'Rocq: go to previous goal end',
      },
    }] = vim_cmd_cb 'CoqGotoGoalPrev',
  },
}

function L.packages()
  return { 'whonore/Coqtail' }
end

function L.load()
  layer.to_vimscript_config(L, 'coqtail_', true, 'coqtail')
  -- User bindings. Coqtail's CoqtailHookDefineMappings needs to be a global
  -- vimscript function with no parameters, so we need to rely on our own
  -- autocommand instead.
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { '*.v', '*.coq' },
    callback = function(event)
      bind(L.config.binds, nil, event.buf)
    end,
  })

  vim.cmd 'packadd Coqtail'
end

return L
