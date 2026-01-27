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
local augroup_eslint = vim.api.nvim_create_augroup("EslintFixAll", { clear = true })

-- フォーマットを無効にするLSP一覧
local format_disabled_lsp = {
  "ts_ls",
}
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- ESLint LSPの場合、保存時に EslintFixAll を実行
    if client.name == "eslint" then
      vim.api.nvim_clear_autocmds({ group = augroup_eslint, buffer = args.buf })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_eslint,
        buffer = args.buf,
        callback = function()
          if vim.fn.exists(":EslintFixAll") > 0 then
            vim.cmd("EslintFixAll")
          end
        end,
      })
      return
    end

    -- フォーマット機能をサポートするLSPで保存時に自動フォーマット
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = args.buf })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            filter = function(c)
              return not vim.tbl_contains(format_disabled_lsp, c.name)
            end,
          })
        end,
      })
    end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
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
  'gopls',
  'eslint',
})
