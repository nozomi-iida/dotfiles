-- ESLint Language Server設定
-- vscode-eslint-language-server を使用
return {
  settings = {
    -- flat config (eslint.config.js) を自動検出
    experimental = {
      useFlatConfig = nil,
    },
  },
}
