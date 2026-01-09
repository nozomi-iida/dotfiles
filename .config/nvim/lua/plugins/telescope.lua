return {
  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    keys = {
      { ';f',   function() require('telescope.builtin').find_files({ no_ignore = false, hidden = true }) end,                      desc = 'Find files' },
      { ';r',   function() require('telescope.builtin').live_grep({ additional_args = function() return { "--hidden" } end }) end, desc = 'Live grep' },
      { '\\\\', function() require('telescope.builtin').buffers() end,                                                             desc = 'Buffers' },
      { ';t',   function() require('telescope.builtin').help_tags() end,                                                           desc = 'Help tags' },
      { ';;',   function() require('telescope.builtin').resume() end,                                                              desc = 'Resume' },
      { ';e',   function() require('telescope.builtin').diagnostics() end,                                                         desc = 'Diagnostics' },
      { ';s',   function() require('telescope.builtin').git_status() end,                                                          desc = 'Git status' },
      {
        'sf',
        function()
          require('telescope').extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = vim.fn.expand('%:p:h'),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 }
          })
        end,
        desc = 'File browser'
      },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local fb_actions = telescope.extensions.file_browser.actions

      telescope.setup {
        defaults = {
          file_ignore_patterns = { "^%node_modules", "^%target", "^%.next" },
          mappings = {
            n = {
              ["q"] = actions.close
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<C-w>"] = function() vim.cmd.normal('vbd') end,
              },
              ["n"] = {
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function() vim.cmd.startinsert() end
              },
            },
          },
        },
      }

      telescope.load_extension("file_browser")
    end,
  },
}
