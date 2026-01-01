return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  -- LSP Installer
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
  },

  -- Mason LSP Bridge
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
  },

  -- Enhanced LSP UI
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
  },

  -- Formatting & Linting
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'davidmh/cspell.nvim',
    },
  },

  -- None-ls Extras
  {
    'nvimtools/none-ls-extras.nvim',
  },

  -- Spell Checking
  {
    'davidmh/cspell.nvim',
  },
}
