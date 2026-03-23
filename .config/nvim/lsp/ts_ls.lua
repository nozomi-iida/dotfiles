-- TypeScript Language Server設定
return {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match('^diffview://') then
      return
    end
    local root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json" })
    if root then
      on_dir(root)
    end
  end,
}
