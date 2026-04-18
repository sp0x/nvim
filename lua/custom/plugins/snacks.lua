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
    dim = {
      enabled = true,
    },
    terminal = {
      enabled = true,
    },
    picker = {
      enabled = true,
      ui_select = true,
      sources = {
        files = {
          hidden = true,
          exclude = { 'node_modules', '.git', '__pycache__', '.venv' },
        },
        grep = {
          hidden = true,
          exclude = { 'node_modules', '.git', '__pycache__', '.venv' },
        },
        recent = {
          exclude = { 'node_modules', '.git', '__pycache__', '.venv' },
        },
      },
    },
  },
  keys = {
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.pickers()
      end,
      desc = '[S]earch [S]elect Picker',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[F]ind to [R]eferences',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent Files',
    },
    {
      '<C-\\>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<C-/>',
      function()
        Snacks.terminal.open()
      end,
      desc = 'Open Terminal',
      mode = { 'n', 't' },
    },
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
      complete = function(ArgLead)
        local sources = vim.tbl_keys(require('snacks').picker.sources)
        table.sort(sources)
        return vim.tbl_filter(function(s)
          return s:find(ArgLead, 1, true) == 1
        end, sources)
      end,
    })
  end,
}
