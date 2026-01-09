return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    init = function()
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["rust"] = false,
      }
    end,
  },

  -- Markdown Support
  {
    'ixru/nvim-markdown',
    ft = 'markdown',
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
    end,
  },

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  },

  -- Debugger
  {
    'puremourning/vimspector',
    cmd = { 'VimspectorInstall', 'VimspectorUpdate' },
    init = function()
      vim.g.vimspector_install_gadgets = { 'CodeLLDB' }
    end,
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
    opts = {
      nx_cmd_root = "npx nx",
    },
    keys = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" }
    },
  },
}
