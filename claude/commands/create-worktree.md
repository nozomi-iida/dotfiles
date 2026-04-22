---
allowed-tools:
  - Bash
  - AskUserQuestion
description: 参考リンク(任意)とユーザー提供の要件からブランチ名を生成し、git gtrでworktreeを作成する。「worktree作って」「WT切って」と言われた時に使用。
targets:
  - "*"
---

# Worktree作成コマンド

## 概要

ユーザーから提供された要件の概要（任意で参考リンクも）を分析し、適切なブランチ名を生成して `git gtr new` でworktreeを作成する。

## 引数フォーマット

```
$ARGUMENTS = [参考リンクURL(任意)] [要件の概要テキスト]
```

- 参考リンク(Notion / GitHub Issue / その他URL)は **任意**。URLが含まれていなければテキストのみで処理する。
- 要件の概要テキストは **必須**。無い場合はStep 1で対話補完する。

## 実行手順

### Step 1: 情報の収集

`$ARGUMENTS` を解析し、以下を確認する:

1. **参考リンク** (任意): URLが含まれていれば抽出して保持する。無ければ無しとして扱い、聞かない。
2. **要件の概要** (必須): URLを除いた残りのテキストを要件として扱う。

**要件の概要が取れない場合のみ、AskUserQuestionで1回だけ質問する。**
参考リンクは任意なので、不足していてもこちらからは聞かない。

### Step 2: ブランチ名の生成

要件の概要を分析し、以下のルールでブランチ名を生成する:

#### 命名ルール

- 要件の本質を表す簡潔な英語のケバブケース（例: `add-user-profile`, `fix-login-validation`）
- prefixは原則 `feature/` を使う。明確にバグ修正・リファクタ・雑務である場合のみ `fix/`, `refactor/`, `chore/` を使う
- 最大50文字以内
- 日本語の要件は英訳して要約する

#### 例

| 要件 | ブランチ名 |
|------|-----------|
| ユーザープロフィール画面の追加 | `feature/add-user-profile` |
| ログインバリデーションのバグ修正 | `fix/login-validation` |
| API レスポンスのキャッシュ導入 | `feature/api-response-cache` |
| 求人詳細画面の速度改善 | `feature/cs-job-detail-speed-improvement` |

### Step 3: ユーザーへの確認

生成したブランチ名をユーザーに提示し、確認を取る:

```
ブランチ名: feature/add-user-profile
このブランチ名でworktreeを作成しますか？（変更があれば指定してください）
```

### Step 4: worktreeの作成

ユーザーの確認後、worktreeを作成する:

```bash
git gtr new {{ブランチ名}}
```

### Step 5: 結果の表示

- 作成されたworktreeのパスを表示
- 参考リンクが指定されていた場合のみ再掲（作業時の参照用）

## 重要な注意事項

1. **質問は最小限**: 不足情報のみまとめて1回で聞く
2. **ブランチ名はユーザー確認必須**: 自動生成した名前を勝手に使わない
3. **git gtr new の実行失敗時**: エラーメッセージを表示し、原因を説明する

## 使用例

```bash
# 参考リンク + 要件
/create-worktree https://notion.so/xxx ユーザープロフィール画面の追加

# GitHub Issueリンク + 要件
/create-worktree https://github.com/org/repo/issues/42 ログインバリデーションのバグ修正

# 要件テキストのみ(リンクなし)
/create-worktree API レスポンスのキャッシュ導入

# 引数なし(要件を対話で補完)
/create-worktree
```

---

<user_requirement>
以下の引数でworktreeを作成してください:
$ARGUMENTS
</user_requirement>
