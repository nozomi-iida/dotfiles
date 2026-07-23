-- ESLint Language Server設定
-- vscode-eslint-language-server を使用
local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

return {
  -- ESLintの設定ファイルがあるディレクトリでのみ起動する。
  -- 見つかったディレクトリをそのままroot(=workspaceFolder)にするので、
  -- monorepoでパッケージ配下にconfigがある場合も
  -- 「Could not find config file」にならない。
  root_dir = function(bufnr, on_dir)
    -- denoプロジェクトでは起動しない
    if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
      return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == '' then
      return
    end

    -- リポジトリの外まで遡らないように.gitの親で打ち切る
    local project_root = vim.fs.root(bufnr, { '.git' }) or vim.fn.getcwd()
    local config_file = vim.fs.find(eslint_config_files, {
      path = fname,
      type = 'file',
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(project_root),
    })[1]

    -- 設定ファイルが無ければattachしない
    if not config_file then
      return
    end

    on_dir(vim.fs.dirname(config_file))
  end,

  settings = {
    -- flat config (eslint.config.js) を自動検出
    experimental = {
      useFlatConfig = nil,
    },
  },
}
