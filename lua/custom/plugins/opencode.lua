return {
  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      -- Keymaps
      local o = require 'opencode'
      vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
        o.ask '@this: '
      end, { desc = 'Ask opencode' })
      vim.keymap.set({ 'n', 'x' }, '<C-o>', function()
        o.select()
      end, { desc = 'Select opencode' })
      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return o.operator '@this '
      end, { desc = 'Append range to OpenCode', expr = true })
      vim.keymap.set({ 'n' }, 'goo', function()
        return o.operator '@this ' .. '_'
      end, { desc = 'Append line to OpenCode', expr = true })
      vim.keymap.set({ 'n' }, '<leader>ou', function()
        o.command 'session.half.page.up'
      end, { desc = 'Scroll OpenCode up' })
      vim.keymap.set({ 'n' }, '<leader>od', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'Scroll OpenCode down' })
    end,
    lazy = false,
  },
}
