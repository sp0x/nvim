-- Key binding for <leader>f to format the current file with :Black

local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':Black<CR>', { noremap = true, silent = true, desc = 'Format the current file with Black' })
