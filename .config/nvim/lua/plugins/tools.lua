return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },

  -- Markdown Support
  {
    'ixru/nvim-markdown',
    ft = 'markdown',
  },

  -- Text Alignment
  {
    'godlygeek/tabular',
    ft = 'markdown',
  },

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  },

  -- Prisma Syntax
  {
    'pantharshit00/vim-prisma',
    ft = 'prisma',
  },

  -- Time Tracking
  {
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },

  -- Input Method Switching (macOS)
  {
    'yoshida-m-3/vim-im-select',
    event = 'InsertEnter',
    cond = function()
      return vim.fn.has('mac') == 1
    end,
  },

  -- Nx Monorepo Support
  {
    'Equilibris/nx.nvim',
    cmd = 'Nx',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('nx').setup {}
    end,
  },
}
