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

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
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
    "Equilibris/nx.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts         = {
      -- See below for config options
      nx_cmd_root = "npx nx",
    },

    -- Plugin will load when you use these keys
    keys         = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" }
    },
  },
}
