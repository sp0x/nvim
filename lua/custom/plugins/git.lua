-- Plugins for neovim that are QoL for Git workflows
return {
    -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>G', '<cmd>Git<CR>', { desc = '[G]it' })
      vim.keymap.set('n', '<leader>gs', '<cmd>Git status<CR>', { desc = 'Git [S]tatus' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git [D]iff' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git [C]ommit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git [P]ush' })
      vim.keymap.set('n', '<leader>ga', '<cmd>Git add %<CR>', { desc = 'Git [A]dd' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Git log<CR>', { desc = 'Git [L]og' })
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = '[G]it [b]lame' })
      -- inline blame
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = '[G]it [b]lame' })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFocusFiles" },
    keys = {
      {
        '<leader>gx',
        function()
          vim.cmd.DiffviewOpen()
        end,
        desc = '[G]it [D]iffview',
      },
        {
            '<leader>gX',
            function()
            vim.cmd.DiffviewClose()
            end,
            desc = '[G]it [D]iffview [C]lose',
        }
    }
  },
}