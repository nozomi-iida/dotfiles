local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = {
    "cssls",
    "graphql",
    "jsonls",
    "lua_ls",
    "prismals",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
    "stylelint_lsp",
  },
  automatic_installation = true
}
