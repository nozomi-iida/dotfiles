local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

local ensure_installed = {
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
  "pyright",
  -- "cspell",
  -- mason-null-lsを使ってしかインストールできないためコメントアウト
  -- "eslint_d",
  -- 'preetierd'
}

-- ruff は python3 venv が必要。ensurepip が使えない環境ではスキップ
if vim.fn.executable("python3") == 1
    and vim.fn.system({ "python3", "-c", "import ensurepip" }) == ""
    and vim.v.shell_error == 0 then
  table.insert(ensure_installed, "ruff")
end

lspconfig.setup {
  ensure_installed = ensure_installed,
  automatic_installation = true,
  automatic_enable = false
}
