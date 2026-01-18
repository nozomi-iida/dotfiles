local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = {
    "cssls",
    "eslint",
    "graphql",
    "jsonls",
    "lua_ls",
    "prismals",
    "rust_analyzer",
    "tailwindcss",
    "ts_ls",
    "stylelint_lsp",
    "gopls",
    -- "cspell",
    -- mason-null-lsを使ってしかインストールできないためコメントアウト
    -- "eslint_d",
    -- 'preetierd'
  },
  automatic_installation = true
}
