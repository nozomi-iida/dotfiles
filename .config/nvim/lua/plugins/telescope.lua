return {
  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      { ';f', mode = 'n' },
      { ';r', mode = 'n' },
      { '\\\\', mode = 'n' },
      { ';t', mode = 'n' },
      { ';;', mode = 'n' },
      { ';e', mode = 'n' },
      { ';s', mode = 'n' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
  },

  -- File Browser Extension
  {
    'nvim-telescope/telescope-file-browser.nvim',
    keys = {
      { 'sf', mode = 'n' },
    },
  },
}
