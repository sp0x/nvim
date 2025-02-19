-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.g.kommentary_create_default_mappings = false

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
    'b3nj5m1n/kommentary',
    config = function()
      vim.keymap.set('n', '<C-k><C-c>', '<Plug>kommentary_line_default', { noremap = false, desc = '[K]omment [Current] line' })
      vim.keymap.set('x', '<C-k><C-c>', '<Plug>kommentary_visual_default', { noremap = false, desc = '[K]omment [Visual] selection' })
      vim.keymap.set('n', '<C-k><C-u>', '<Plug>kommentary_line_default', { noremap = false, desc = '[U]ncomment [Current] line' })
      vim.keymap.set('x', '<C-k><C-u>', '<Plug>kommentary_visual_default', { noremap = false, desc = '[U]ncomment [Visual] selection' })
      -- Visual
      -- vim.keymap.set('x', '<C-k><C-c>', '<Plug>kommentary_line_default', { noremap = false, desc = '[K]omment [Visual] selection' })
    end,
  },

  {
    'm-demare/attempt.nvim', -- No need to specify plenary as dependency
    config = function()
      local attempt = require 'attempt'
      attempt.setup {
        ext_options = { 'lua', 'js', 'py', 'cpp', 'c', 'json', 'ts', 'tsx', 'html', 'css', 'scss', 'md', 'sh', 'yaml', 'toml' },
      }
      function map(mode, l, r, opts)
        opts = opts or {}
        opts = vim.tbl_extend('force', { silent = true }, opts)
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<leader>an', attempt.new_select, { desc = '[A]ttempt with ex' }) -- new attempt, selecting extension
      map('n', '<leader>ai', attempt.new_input_ext, { desc = '[A]ttempt without ext' }) -- new attempt, inputing extension
      map('n', '<leader>ar', attempt.run, { desc = '[A]ttempt [r]un' }) -- run attempt
      map('n', '<leader>ad', attempt.delete_buf, { desc = '[A]ttempt [d]elete buf' }) -- delete attempt from current buffer
      map('n', '<leader>ac', attempt.rename_buf, { desc = '[A]ttempt rename buffer' }) -- rename attempt from current buffer
      map('n', '<leader>al', 'Telescope attempt') -- search through attempts
    end,
  },
  {
    -- HTTP REST-Client Interface
    'mistweaverco/kulala.nvim',
    opts = {},
    config = function() end,
  },
  {
    'AndrewRadev/splitjoin.vim',
    opts = {},
    config = function() end,
  },
  {
    'justinmk/vim-sneak',
    config = function()
      vim.keymap.set('n', 'f', '<Plug>Sneak_f', { noremap = false, desc = 'Sneak [f]ind' })
      vim.keymap.set('n', 'F', '<Plug>Sneak_F', { noremap = false, desc = 'Sneak [F]ind' })
      vim.keymap.set('n', 't', '<Plug>Sneak_t', { noremap = false, desc = 'Sneak [t]ill' })
      vim.keymap.set('n', 'T', '<Plug>Sneak_T', { noremap = false, desc = 'Sneak [T]ill' })
      vim.keymap.set('n', 's', '<Plug>Sneak_s', { noremap = false, desc = '[s]neak' })
    end,
  },
  {
    'smartpde/telescope-recent-files',
    config = function()
      require('telescope').load_extension 'recent_files'
      vim.api.nvim_set_keymap('n', '<Leader><Leader>', [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]], { noremap = true, silent = true })
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        ui = {},
      }
      vim.keymap.set('n', '<C-A-t>', '<cmd>Lspsaga term_toggle<CR>', { desc = 'LSP [T]erminal toggle' })
      vim.keymap.set('n', '<leader>lf', '<cmd>Lspsaga finder<CR>', { desc = '[L]sp [F]ind all' })
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
      vim.keymap.set('i', '<C-S-k>', '<cmd>Lspsaga hover_doc<CR>', { desc = '[L]sp docs' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  {
    'psf/black',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      local augroup = vim.api.nvim_create_augroup('Lsp Formatting', {})

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds {
              group = augroup,
              buffer = bufnr,
            }

            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format {
                  bufnr = bufnr,
                }
              end,
            })
          end
        end,
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui' },
    config = function()
      require('dap-python').setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    -- Multi cursor plugin
    'mg979/vim-visual-multi',
  },
  {
    'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup {}
    end,
  },
}
