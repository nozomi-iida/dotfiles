return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "master",  -- 安定版を使用
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "go", "tsx", "toml", "json", "yaml",
          "css", "html", "lua", "graphql", "typescript", "vimdoc"
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
