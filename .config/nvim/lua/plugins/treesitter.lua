return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      -- MoonBit tree-sitter パーサーを登録（TSUpdateイベント時にインストール可能にする）
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").moonbit = {
            tier = 4,
            install_info = {
              url = "https://github.com/moonbitlang/tree-sitter-moonbit",
              revision = "main",
              branch = "main",
              queries = "queries",
            },
          }
        end,
      })

      local langs = {
        "bash", "go", "rust", "tsx", "toml", "json", "yaml",
        "css", "html", "lua", "graphql", "typescript", "vimdoc",
      }
      for _, lang in ipairs(langs) do
        pcall(vim.treesitter.language.add, lang)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
