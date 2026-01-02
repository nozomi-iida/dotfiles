return {
  -- Auto Pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
  },

  -- Auto Tag (HTML/JSX)
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'tsx', 'jsx' },
  },

  -- Surround Operations
  {
    'machakann/vim-sandwich',
    keys = { 'sa', 'sd', 'sr' },
  },

  -- Smart Commenting
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n' },
      { 'gc', mode = 'v' },
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },

  -- Context-aware Comment Strings
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}
