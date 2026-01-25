return {
  -- Git Signs in Gutter
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local opts = function(desc) return { buffer = bufnr, desc = desc } end

        vim.keymap.set('n', '<leader>hs', function()
          gs.stage_hunk()
          vim.cmd('silent write')
          gs.next_hunk()
        end, opts('Stage hunk'))
        vim.keymap.set('n', '<leader>hr', function() gs.reset_hunk() end, opts('Reset hunk'))
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts('Preview hunk'))
      end,
    },
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
    init = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
    end,
  },

  -- Diffview
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Open Diffview' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Branch History' },
    },
    opts = {
      watch_index = false,
      hooks = {
        view_opened = function()
          vim.cmd('tabmove')
        end,
        diff_buf_win_enter = function()
          vim.opt_local.foldlevel = 99
        end,
      },
      keymaps = {
        view = {
          { 'n', '<tab>',   false },
          { 'n', '<s-tab>', false },
          { 'n', '<C-tab>', false },
          { 'n', 's',       false },
          { 'n', 'R',       '<cmd>DiffviewRefresh<cr>', { desc = 'Refresh' } },
        },
        file_panel = {
          { 'n', '<tab>',   false },
          { 'n', '<s-tab>', false },
          { 'n', '<C-tab>', false },
          { 'n', 's',       false },
          { 'n', 'R',       '<cmd>DiffviewRefresh<cr>', { desc = 'Refresh' } },
        },
        file_history_panel = {
          { 'n', '<tab>',   false },
          { 'n', '<s-tab>', false },
          { 'n', '<C-tab>', false },
          { 'n', 's',       false },
        },
      },
    },
  },
}
