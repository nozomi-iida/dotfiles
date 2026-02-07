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

-- can't keep indent when press enter in comment block
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.comments = ":///,://!,://"
  end,
})

-- No auto commenting new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end
})

function TrimWhitespace()
  local save = vim.fn.winsaveview()
  pcall(vim.cmd, [[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local filetype = vim.bo.filetype
    if filetype ~= "markdown" then
      TrimWhitespace()
    end
  end
})
