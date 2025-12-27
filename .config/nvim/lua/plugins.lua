local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installe")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim'     -- Common utilities
  use 'onsails/lspkind-nvim'      -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'        -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'      -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'          -- Completion
  use 'neovim/nvim-lspconfig'     -- LSP
  use {
    'nvimtools/none-ls.nvim',
    requires = {
      'nvimtools/none-ls-extras.nvim',
      'davidmh/cspell.nvim',
    }
  } -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'nvimdev/lspsaga.nvim'
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'saadparwaiz1/cmp_luasnip',
    }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'akinsho/nvim-bufferline.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use {
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'github/copilot.vim'
  use 'ixru/nvim-markdown'
  use 'godlygeek/tabular'
  use 'norcalli/nvim-colorizer.lua'
  use {
    'yoshida-m-3/vim-im-select',
    cond = function()
      return vim.fn.has("mac") == 1
    end
  }
  use 'machakann/vim-sandwich'
  -- use 'vim-denops/denops.vim'
  use 'lambdalisue/gin.vim'
  -- use {
  --   'kdheepak/lazygit.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --   }
  -- }
  use 'kdheepak/lazygit.nvim'
  use {
    'Equilibris/nx.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("nx").setup {}
    end
  }
  use 'pantharshit00/vim-prisma'
  use 'wakatime/vim-wakatime'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  -- use {
  --   "0x00-ketsu/markdown-preview.nvim",
  --   config = function()
  --     require('markdown-preview').setup {}
  --   end
  -- }
  use {
    "antosha417/nvim-lsp-file-operations",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  }
end)
