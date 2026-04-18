local M = {}

-- A list of strings, or name: { options for the server like 'capabilities'}
M.ensure_installed = {
  'black',
--  'pyright',
  'ruff',
  'mypy',
  'debugpy',
  'ty'
}

return M
