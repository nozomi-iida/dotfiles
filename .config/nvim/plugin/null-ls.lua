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

local eslint_files = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" }
local cspell = require("cspell")
local cspell_config = {
  find_json = function()
    return vim.fn.expand("~/.config/nvim/cspell.json")
  end
}
local sources = {
  require("none-ls.diagnostics.eslint_d").with({
    diagnostics_format = '[eslint] #{m}\n(#{c})',
    condition = function(utils)
      return utils.has_file(eslint_files)
    end,
  }),
  null_ls.builtins.diagnostics.fish,
  require("none-ls.formatting.eslint_d").with({
    condition = function(utils)
      return utils.has_file(eslint_files)
    end,
  }),
  require("none-ls.code_actions.eslint_d"),
  null_ls.builtins.diagnostics.stylelint.with({
    diagnostics_format = '[stylelint] #{m}\n(#{c})',
  }),
  null_ls.builtins.formatting.stylelint,
  null_ls.builtins.formatting.prettierd.with({
    condition = function(utils)
      return utils.has_file({ ".prettierrc.json", ".prettierrc" })
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
