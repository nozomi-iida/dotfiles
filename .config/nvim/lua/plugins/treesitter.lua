return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          "go",
          "tsx",
          "toml",
          "json",
          "yaml",
          "css",
          "html",
          "lua",
          "graphql",
          "typescript",
          "vimdoc",
        },
        auto_install = true,
      })

      -- FileTypeごとにhighlight/indentを有効化
      local disable_ft = { "vim" }
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if vim.tbl_contains(disable_ft, vim.bo.filetype) then
            return
          end
          local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
          if lang and pcall(vim.treesitter.language.add, lang) then
            pcall(vim.treesitter.start)
            pcall(function()
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end)
          end
        end,
      })
    end,
  },
}
