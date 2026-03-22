-- Tailwind CSS Language Server設定
-- returnだとnvim-lspconfigのデフォルトにマージで負けるため、vim.lsp.configで上書きする
vim.lsp.config('tailwindcss', {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "jsx",
  },
})

return {}
