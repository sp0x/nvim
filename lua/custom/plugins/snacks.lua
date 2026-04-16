return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    scroll = {
      enabled = true,
    },
    quickfiles = {
      enabled = true,
    },
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
  keys = {
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Picker' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader>fr', function() Snacks.picker.lsp_references() end, desc = '[F]ind to [R]eferences' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
    { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath 'config' }) end, desc = '[S]earch [N]eovim files' },
    { '<leader><leader>', function() Snacks.picker.recent() end, desc = 'Recent Files' },
  },
  init = function()
    vim.api.nvim_create_user_command('Pick', function(cmd)
      local source = cmd.args
      local Snacks = require 'snacks'
      if source == '' then
        Snacks.picker.pickers()
      elseif Snacks.picker[source] then
        Snacks.picker[source]()
      else
        vim.notify('Unknown picker: ' .. source, vim.log.levels.ERROR)
      end
    end, {
      nargs = '?',
      complete = function()
        return vim.tbl_keys(Snacks.picker.sources)
      end,
    })
  end,
}
