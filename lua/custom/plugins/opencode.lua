return {
  {
    'nickjvandyke/opencode.nvim',
    config = function()
      local opencode_cmd = 'opencode'
      local active_terminal

      local function open_terminal(cwd, session_id)
        local command = { opencode_cmd, cwd }
        if session_id then
          vim.list_extend(command, { '--session', session_id })
        end

        local terminal = require('snacks.terminal').get(command, {
          cwd = cwd,
          count = 1,
          win = { position = 'right', enter = false },
        })
        if active_terminal and active_terminal.window ~= terminal and active_terminal.window:win_valid() then
          active_terminal.window:hide()
        end
        terminal:show()
        active_terminal = { window = terminal, cwd = cwd }
      end

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            open_terminal(vim.fn.getcwd())
          end,
        },
      }

      -- Keymaps
      local o = require 'opencode'

      local function run_with_session(action)
        local cwd = vim.fn.getcwd()
        require('opencode.server.discovery')
          .get()
          :next(function(server)
            return server:resolve_session():next(function(session)
              if vim.fn.getcwd() ~= cwd then
                vim.notify('OpenCode cwd changed; retry from the original project.', vim.log.levels.WARN)
                return
              end
              open_terminal(cwd, session.id)
              action()
            end)
          end)
          :catch(function(err)
            if not err then
              return
            end
            if tostring(err):find('No OpenCode session found', 1, true) then
              open_terminal(cwd)
            end
            vim.notify(tostring(err), vim.log.levels.WARN, { title = 'OpenCode' })
          end)
      end

      local function toggle_opencode()
        local cwd = vim.fn.getcwd()
        if not active_terminal or active_terminal.cwd ~= cwd or not active_terminal.window:buf_valid() then
          open_terminal(cwd)
        end

        local terminal = active_terminal.window
        if terminal:win_valid() and vim.api.nvim_get_current_win() == terminal.win then
          terminal:hide()
        else
          terminal:show():focus()
        end
      end

      vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
        run_with_session(function()
          o.ask '@this: '
        end)
      end, { desc = 'Ask opencode' })
      vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
        run_with_session(function()
          o.select()
        end)
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
      vim.keymap.set({ 'n', 't' }, '<C-.>', toggle_opencode, { desc = 'Toggle OpenCode' })
    end,
    lazy = false,
  },
}
