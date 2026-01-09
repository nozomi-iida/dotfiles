return {
  -- Auto Pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },

  -- Auto Tag (HTML/JSX)
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'tsx', 'jsx' },
    opts = {},
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
    config = function()
      require('Comment').setup {
        pre_hook = function(ctx)
          if vim.bo.filetype == 'typescriptreact' then
            local U = require('Comment.utils')
            local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
            end
            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      }
    end,
  },
}
