-- Neovim 0.11の新しいLSP API設定

-- cmp_nvim_lspのcapabilitiesをグローバル設定
local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status then
  vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp.default_capabilities()
  })
end

-- LspAttach autocmdでフォーマット設定
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == 'lua_ls' or client.name == 'rust_analyzer' then
      -- lua_lsとrust_analyzerの場合、保存時に自動フォーマット
      vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = args.buf })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf })
        end,
      })
    end
  end,
})

-- 全てのLSPサーバーを有効化
vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'tailwindcss',
  'rust_analyzer',
  'cssls',
  'graphql',
  'jsonls',
  'prismals',
  'stylelint_lsp',
  'denols',
  'clangd',
})
