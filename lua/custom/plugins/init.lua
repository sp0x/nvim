-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'github/copilot.vim' },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
    },
    build = 'make tiktoken',
    opts = {},
    config = function()
      local chat = require 'CopilotChat'
      local select = require 'CopilotChat.select'
      chat.setup {}
      vim.keymap.set('n', '<leader>?', chat.toggle, { desc = 'Github copilot chat toggle' })
      vim.keymap.set('n', '<leader>ge', function()
        chat.ask('Explain this code to me', {
          selection = function(source)
            return select.line(source) or select.visual(source) or select.buffer(source)
          end,
          --           context = { 'buffers', 'files', 'register:+', 'selection' },
        })
      end, { desc = '[G]ithub Copilot [E]xplain the current line | visual block | buffer' })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
    config = function()
      require('typescript-tools').setup {}
    end,
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = function()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = 'Toggle [U]ndo tree' })
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', '<cmd>Git status<CR>', { desc = 'Git [S]tatus' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git [D]iff' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>', { desc = 'Git [C]ommit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git [P]ush' })
      vim.keymap.set('n', '<leader>ga', '<cmd>Git add %<CR>', { desc = 'Git [A]dd' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Git log<CR>', { desc = 'Git [L]og' })
    end,
  },

  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local ll = require 'lualine'
      ll.setup {}
    end,
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
      require('Comment').setup()
    end,
  },
}
