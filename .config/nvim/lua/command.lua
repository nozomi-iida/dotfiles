function FileName()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('*', filename)
  vim.fn.setreg('+', filename)
end

vim.cmd('command! FileName lua FileName()')

vim.cmd('command! FileName lua FileName()')


function FileNameRelative()
  local filename = vim.fn.expand('%.')
  vim.fn.setreg('*', filename)
  vim.fn.setreg('+', filename)
end

vim.cmd('command! FileNameRelative lua FileNameRelative()')
