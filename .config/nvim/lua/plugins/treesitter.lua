return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- main ブランチは Neovim 0.12 以降が必須で、遅延読み込みには対応していない
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require("nvim-treesitter")

      -- MoonBit tree-sitter パーサーを登録
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").moonbit = {
            install_info = {
              url = "https://github.com/moonbitlang/tree-sitter-moonbit",
              branch = "main",
            },
          }
        end,
      })

      ts.install({
        "bash", "go", "rust", "tsx", "toml", "json", "yaml",
        "css", "html", "lua", "graphql", "typescript", "vimdoc", "prisma", "python",
      })

      -- ハイライト・インデントを有効化する
      local function start(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang or not vim.list_contains(ts.get_available(), lang) then
            return
          end
          if vim.list_contains(ts.get_installed(), lang) then
            start(args.buf, lang)
          else
            -- 未インストールのパーサーは自動でインストールしてから有効化する
            ts.install(lang):await(function()
              vim.schedule(function() start(args.buf, lang) end)
            end)
          end
        end,
      })
    end,
  },
}
