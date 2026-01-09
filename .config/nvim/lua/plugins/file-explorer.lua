return {
  -- File Tree Explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'antosha417/nvim-lsp-file-operations',
    },
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del('n', 's', { buffer = bufnr })
      end

      require('nvim-tree').setup({
        on_attach = my_on_attach,
        view = {
          width = 35,
          relativenumber = true,
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "",
                arrow_open = "",
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          custom = { ".DS_Store" },
        },
        git = {
          ignore = false,
        },
      })
    end,
    keys = {
      { '<leader>ee', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
      { '<leader>ef', '<cmd>NvimTreeFindFile<CR>', desc = 'Open file explorer on current file' },
      { '<leader>ec', '<cmd>NvimTreeCollapse<CR>', desc = 'Collapse file explorer' },
      { '<leader>er', '<cmd>NvimTreeRefresh<CR>', desc = 'Refresh file explorer' },
    },
  },

  -- Web Dev Icons
  { 'nvim-tree/nvim-web-devicons' },

  -- LSP File Operations
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
