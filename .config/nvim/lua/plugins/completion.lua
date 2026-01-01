return {
  -- Completion Engine
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Buffer Completion Source
  {
    'hrsh7th/cmp-buffer',
  },

  -- LSP Completion Source
  {
    'hrsh7th/cmp-nvim-lsp',
  },

  -- VSCode-like Pictograms
  {
    'onsails/lspkind-nvim',
  },

  -- Snippet Engine
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- LuaSnip Completion Source
  {
    'saadparwaiz1/cmp_luasnip',
  },
}
