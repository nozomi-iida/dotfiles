vim.keymap.set('n', '<Leader>gg', '<cmd>LazyGit<CR>', {
  noremap = true,
  silent = true,
  desc = 'Open LazyGit'
})

vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.9
vim.g.lazygit_floating_window_use_plenary = 0

vim.g.lazygit_use_neovim_remote = 1
