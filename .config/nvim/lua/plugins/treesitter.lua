return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- nvim-treesitter のデフォルトブランチは main に切り替わったが、
    -- main は Neovim 0.12 (nightly) 必須の別物のため master に固定する
    branch = 'master',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      -- MoonBit tree-sitter パーサーを登録
      require("nvim-treesitter.parsers").get_parser_configs().moonbit = {
        install_info = {
          url = "https://github.com/moonbitlang/tree-sitter-moonbit",
          revision = "main",
          branch = "main",
          files = { "src/parser.c" },
        },
        filetype = "moonbit",
      }

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "go", "rust", "tsx", "toml", "json", "yaml",
          "css", "html", "lua", "graphql", "typescript", "vimdoc", "prisma", "python",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
