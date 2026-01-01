return {
  -- Common dependencies
  { 'nvim-lua/plenary.nvim',        lazy = false },
  { 'kyazdani42/nvim-web-devicons', lazy = false },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
  },

  -- Buffer Tabs
  {
    'akinsho/nvim-bufferline.lua',
    event = 'VeryLazy',
  },

  -- Color Highlighter
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
  },
}
