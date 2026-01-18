function FileName()
  local filename = vim.fn.expand('%:t:r')
  vim.fn.setreg('*', filename)
  vim.fn.setreg('+', filename)
end

vim.cmd('command! FileName lua FileName()')

function FileNameRelative()
  local filepath = vim.fn.expand('%:p')
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local relative
  if git_root and vim.v.shell_error == 0 then
    relative = filepath:sub(#git_root + 2)
  else
    relative = vim.fn.expand('%:.')
  end
  vim.fn.setreg('*', relative)
  vim.fn.setreg('+', relative)
end

vim.cmd('command! FileNameRelative lua FileNameRelative()')

-- insetモードでCtrl-Dを2回押すと、YYYY-MM-DD HH:MM:SS形式の日付と時間を挿入
vim.api.nvim_set_keymap('i', '<C-D><C-D>', '<C-R>=strftime("`%Y-%m-%d %H:%M:%S`")<CR><ESC>',
  { noremap = true, silent = true })
