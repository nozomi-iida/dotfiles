function FileName()
  local filename = vim.fn.expand('%:t')
  vim.fn.setreg('*', filename)
  vim.fn.setreg('+', filename)
end

vim.cmd('command! FileName lua FileName()')

function FileNameRelative()
  local filename = vim.fn.expand('%.')
  vim.fn.setreg('*', filename)
  vim.fn.setreg('+', filename)
end

vim.cmd('command! FileNameRelative lua FileNameRelative()')

-- insetモードでCtrl-Dを2回押すと、YYYY-MM-DD HH:MM:SS形式の日付と時間を挿入
vim.api.nvim_set_keymap('i', '<C-D><C-D>', '<C-R>=strftime("`%Y-%m-%d %H:%M:%S`")<CR><ESC>',
  { noremap = true, silent = true })
