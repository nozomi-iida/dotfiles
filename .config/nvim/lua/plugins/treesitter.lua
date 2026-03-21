return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      -- MoonBit tree-sitter パーサーを登録
      require("nvim-treesitter.parsers").moonbit = {
        tier = 4,
        install_info = {
          url = "https://github.com/moonbitlang/tree-sitter-moonbit",
          revision = "main",
          branch = "main",
          queries = "queries",
        },
      }

      require('nvim-treesitter').install({
        "go", "tsx", "toml", "json", "yaml",
        "css", "html", "lua", "graphql", "typescript", "vimdoc"
      })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
