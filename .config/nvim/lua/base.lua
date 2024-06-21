vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }
vim.opt.wrap = false         -- No Wrap lines
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true


vim.cmd('au FileType * set fo-=r fo-=o') -- No auto commenting new lines

function TrimWhitespace()
  local save = vim.fn.winsaveview()
  vim.api.nvim_exec([[
        keeppatterns %s/\s\+$//e
    ]], false)
  vim.fn.winrestview(save)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = TrimWhitespace
})
