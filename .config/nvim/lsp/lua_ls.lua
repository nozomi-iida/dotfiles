-- Lua Language Server設定
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      diagnostics = {
        -- Neovimのglobal変数'vim'を認識させる
        globals = { 'vim' },
      },
      workspace = {
        -- Neovimのruntimeファイルをライブラリとして認識
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}
