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

-- Tab navigation
vim.keymap.set({ 'n', 'i' }, '<C-S-n>', '<cmd>tabnew<CR>', { desc = 'Open a new tab' })

-- LSP
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Open LSP [e]rror diagnostic' })

-- Http files
vim.filetype.add {
  extension = {
    http = 'http',
  },
}

vim.opt.guicursor = ''

-- Python settings
local python_exe = vim.fn.executable 'python3' -- Or "python" if you prefer

if python_exe ~= 0 then                        -- Check if python3 is executable
  vim.g.python3_host_prog = vim.fn.exepath 'python3'
  print('Python 3 executable found: ' .. vim.g.python3_host_prog)
else
  print 'Warning: Python 3 executable not found. Check your PATH.'

  -- Fallback to 'python' if 'python3' is not found.
  python_exe = vim.fn.executable 'python'
  if python_exe ~= 0 then
    vim.g.python_host_prog = vim.fn.exepath 'python'
    print('Python executable found: ' .. vim.g.python_host_prog)
  else
    print 'Warning: Python executable not found. Check your PATH.'
  end
end

vim.opt.title = true
vim.opt.titlelen = 80 -- Maximum length of the title
-- vim.opt.titlestring = '%{expand("%:p")} [%{mode()}]'
vim.opt.titlestring = [[%f %h%m%r%w %{v:progname} (%{tabpagenr()} of %{tabpagenr('$')})]]
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.cmd 'colorscheme retrobox'
-- wl-clipboard integration
vim.opt.clipboard = 'unnamedplus'
