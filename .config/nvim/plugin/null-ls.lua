local status, null_ls = pcall(require, "null-ls")
if (not status) then return end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
    timeout_ms = 10000,
  })
end

-- local eslint_files = { ".eslintrc.js", ".eslintrc.json", ".eslintrc", "eslint.config.js", "eslint.config.mjs" }
local prettier_files = { ".prettierrc.json", ".prettierrc", "prettier.config.js" }

local function find_root(files)
  return function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local found = vim.fs.find(files, {
      upward = true,
      path = vim.fs.dirname(bufname),
    })
    if #found > 0 then
      return vim.fs.dirname(found[1])
    end
    return nil
  end
end

local cspell = require("cspell")
local cspell_config = {
  find_json = function()
    return vim.fn.expand("~/.config/nvim/cspell.json")
  end
}
local sources = {
  -- vscode-eslint-language-server を使用しているため無効化
  -- require("none-ls.diagnostics.eslint_d").with({
  --   diagnostics_format = '[eslint] #{m}\n(#{c})',
  --   root_dir = find_root(eslint_files),
  -- }),
  -- require("none-ls.formatting.eslint_d").with({
  --   root_dir = find_root(eslint_files),
  -- }),
  -- require("none-ls.code_actions.eslint_d").with({
  --   root_dir = find_root(eslint_files),
  -- }),
  null_ls.builtins.diagnostics.stylelint.with({
    diagnostics_format = '[stylelint] #{m}\n(#{c})',
  }),
  null_ls.builtins.formatting.stylelint,
  null_ls.builtins.formatting.prettierd.with({
    root_dir = find_root(prettier_files),
    runtime_condition = function()
      return find_root(prettier_files)() ~= nil
    end,
  }),
  cspell.diagnostics.with({
    config = cspell_config,
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity["WARN"]
    end,
  }),
  cspell.code_actions.with({
    config = cspell_config,
  })
}

null_ls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
  ensure_installed = {
    'prettierd',
  }
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
