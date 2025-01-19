vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.termguicolors = true

vim.opt.scrolloff = 8
vim.signcolumn = 'yes'
-- vim.opt.isfname:append '@@'

vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Fold settings
vim.opt.foldlevel = 99
vim.foldopen = 'all'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '0'
vim.opt.foldtext = ''
vim.opt.foldlevelstart = 3

-- Json beautify with formatprg and jq
vim.opt.formatprg = 'jq .'
vim.keymap.set('n', '<leader>kf', "<cmd>:%!jq '.'<CR>", { desc = 'Format json with jq' })

-- Http files
vim.filetype.add {
  extension = {
    http = 'http',
  },
}
