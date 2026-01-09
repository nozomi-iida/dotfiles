return {
  -- Common dependencies
  { 'nvim-lua/plenary.nvim',        lazy = false },
  { 'kyazdani42/nvim-web-devicons', lazy = false },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'solarized_dark',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
          'filename',
          file_status = true,
          path = 0
        } },
        lualine_x = {
          { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
          'encoding',
          'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
          'filename',
          file_status = true,
          path = 1
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { 'fugitive' }
    },
  },

  -- Buffer Tabs
  {
    'akinsho/nvim-bufferline.lua',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = "tabs",
        separator_style = 'slant',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true
      },
      highlights = {
        separator = {
          guifg = '#073642',
          guibg = '#002b36',
        },
        separator_selected = {
          guifg = '#073642',
        },
        background = {
          guifg = '#657b83',
          guibg = '#002b36'
        },
        buffer_selected = {
          guifg = '#fdf6e3',
          gui = "bold",
        },
        fill = {
          guibg = '#073642'
        }
      },
    },
    keys = {
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    },
  },

  -- Color Highlighter
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      'typescript',
      'css',
    },
  },
}
