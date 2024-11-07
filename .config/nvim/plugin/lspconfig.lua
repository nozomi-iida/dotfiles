local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

-- Lua
nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },

      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

-- TypeScript
nvim_lsp.ts_ls.setup {
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

nvim_lsp.tailwindcss.setup {}

-- Rust
nvim_lsp.rust_analyzer.setup {
  filetypes = { "rust" }
}

nvim_lsp.cssls.setup {
  capabilities = capabilities,
  filetypes = { "css", "scss", "less" },
}

-- Graphql
nvim_lsp.graphql.setup {
  root_dir = nvim_lsp.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
  filetypes = { "graphql" }
}

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  filetypes = { "json" }
}

nvim_lsp.prismals.setup {
  capabilities = capabilities,
  filetypes = { "prisma" }
}

nvim_lsp.stylelint_lsp.setup {
  -- not working
  stylelintplus = {
    autoFixOnSave = true,
    autoFixOnFormat = true,
  },
}

nvim_lsp.denols.setup {
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}
