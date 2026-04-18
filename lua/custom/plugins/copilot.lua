-- Copilot related plugins configuration
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
      chat.setup {
        model = 'gpt-5.2-codex',
        temperature = 0.1,
        trusted_tools = { 'buffer', 'file', 'glob', 'grep', 'gitdiff', 'register', 'selection',
         'diagnostic', 'todo', 'command', 'clipboard'
       },
        -- Enter insert mode when opening chat
        auto_insert_mode = true,
        -- Show virtual-text help while waiting for input
        show_help = true,

      }
      vim.keymap.set('n', '<leader>?', chat.toggle, { desc = 'Github copilot chat toggle' })
      vim.keymap.set('n', '<leader>cq', function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          chat.ask(input, { resources = 'buffer' })
        end
      end, { desc = '[C]opilot [Q]uick chat' })
      vim.keymap.set('n', '<leader>cm', chat.select_model, { desc = 'Copilot Chat models' })
      vim.keymap.set('n', '<leader>ge', function()
        chat.ask('Explain this code to me', {
          selection = function(source)
            return select.line(source) or select.visual(source) or select.buffer(source)
          end,
          --           context = { 'buffers', 'files', 'register:+', 'selection' },
        })
      end, { desc = '[G]ithub Copilot [E]xplain the current line | visual block | buffer' })
      
      -- Review selection / buffer
      vim.keymap.set({ 'n', 'v' }, '<leader>cr', function()
        chat.ask '/Review'
      end, { desc = 'Copilot Chat review' })

      -- Fix selection / buffer
      vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
        chat.ask '/Fix'
      end, { desc = 'Copilot Chat fix' })

      -- Generate tests
      vim.keymap.set({ 'n', 'v' }, '<leader>ct', function()
        chat.ask '/Tests'
      end, { desc = 'Copilot Chat tests' })

      -- Commit message from staged changes
      vim.keymap.set('n', '<leader>cg', function()
        chat.ask '/Commit'
      end, { desc = 'Copilot Chat commit message' })
    end,
  },
}