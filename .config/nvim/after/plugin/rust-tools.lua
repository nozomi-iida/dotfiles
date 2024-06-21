local status, rust_tools = pcall(require, "rust-tools")
if (not status) then return end

rust_tools.setup({
  tools = {
    autoSetHints = true,
  },
  server = {},
})

-- Because on_attach of lspconfig is turned off
vim.g.rustfmt_autosave = 1

