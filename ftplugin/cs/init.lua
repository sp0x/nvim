-- insatll with cargo install --git https://github.com/SofusA/csharp-language-server
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs',
  callback = function(args)
    local root_dir = vim.fs.dirname(vim.fs.find({ '.sln', '.csproj', '.git' }, { upward = true })[1])
    vim.lsp.start {
      name = 'csharp-language-server',
      cmd = { 'csharp-language-server' },
      root_dir = root_dir,
    }
  end,
})
