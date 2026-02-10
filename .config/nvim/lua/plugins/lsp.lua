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
    config = function()
      require('lspsaga').setup({
        ui = {
          winblend = 10,
          border = 'rounded',
          colors = {
            normal_bg = '#002b36'
          }
        },
        symbol_in_winbar = {
          enable = false
        }
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<C-j>', function()
        require('lspsaga.diagnostic'):goto_next({
          severity = { min = vim.diagnostic.severity.WARN }
        })
      end, opts)
      vim.keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
      vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
      vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
      vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
    end,
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
