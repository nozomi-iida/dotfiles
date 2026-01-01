return {
  -- Git Signs in Gutter
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Git Blame & Browse
  {
    'dinhhuy258/git.nvim',
    keys = {
      { '<leader>gb', mode = 'n' },
      { '<leader>go', mode = 'n' },
    },
  },

  -- LazyGit Integration
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open LazyGit' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
