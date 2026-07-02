---
allowed-tools:
  - Read
  - Write
  - Glob
  - Bash
  - AskUserQuestion
description: 今の会話の内容を元にnozo-blogの記事を作成する。どのセッションからでも実行可能。「nozo-blogに記事書いて」「ブログ記事にして」と言われた時に使用。
targets:
  - "*"
---

# nozo-blog 記事作成コマンド

## 概要

現在の会話で学んだこと・作業した内容を元に、nozo-blogリポジトリに記事(mdx)を作成する。
どのClaude Codeセッションからでも実行できるよう、nozo-blogへは**絶対パス**で書き込む。

**nozo-blogのパス**: `/home/nozomi/ghq/github.com/nozomi-iida/nozo-blog`
**記事の保存先**: `{nozo-blog}/src/articles/{category}/{YYYY_MM_DD}_{slug}.mdx`

## 引数フォーマット

```
$ARGUMENTS = [--category programmings|poems|atcoder] [--title タイトル] [--slug slug] [記事にする内容の補足・テーマ]
```

### オプション引数

- `--category <name>`: カテゴリ（未指定時は `programmings`）
- `--title <title>`: 記事タイトル（未指定時は会話内容から自動生成）
- `--slug <slug>`: ファイル名用の英語スラッグ（未指定時は会話内容から自動生成）
- その他: どの話題を記事にするか・補足したい内容（会話が長い場合の絞り込みに使う）

## 実行手順

### Step 1: 引数の解析

`$ARGUMENTS` から `--category` / `--title` / `--slug` と、その他の補足指示を抽出する。

### Step 2: nozo-blogの存在確認

```bash
test -d /home/nozomi/ghq/github.com/nozomi-iida/nozo-blog/src/articles && echo OK
```

存在しない場合はエラーを表示して終了する。

### Step 3: 記事にする内容の決定

現在の会話を振り返り、記事化する技術的な知見・作業内容を整理する。

- 補足指示（その他の引数）がある場合は、その話題を優先する
- 会話に複数の話題がある場合は、最も記事として成立しそうなものを選ぶ
- 会話から記事化できる内容が見つからない場合は、`AskUserQuestion` で何について書くか確認する

### Step 4: タイトルとスラッグの決定

- **タイトル**(`--title` 未指定時): 記事の内容を表す日本語タイトル（簡潔に）
- **スラッグ**(`--slug` 未指定時): 記事の主題を表す英語のケバブケース（下記ルール参照）

### Step 5: 既存記事との重複チェック

```bash
ls /home/nozomi/ghq/github.com/nozomi-iida/nozo-blog/src/articles/{category}/ | grep {slug}
```

同じスラッグの記事が既にある場合はユーザーに確認する。

### Step 6: 公開日時の取得

```bash
date -u +"%Y-%m-%dT%H:%M:%S.000Z"
```

で `publishedAt` 用のISO 8601形式の現在時刻を取得する。
ファイル名の日付は `date +"%Y_%m_%d"` で取得する。

### Step 7: 記事の作成

下記のフォーマット・スタイルガイドに従って記事本文を書き、
`{nozo-blog}/src/articles/{category}/{YYYY_MM_DD}_{slug}.mdx` に保存する。

### Step 8: 結果の表示

- 作成したファイルの絶対パスを表示
- `isPublished: false`（下書き）で作成したことを通知
- 「内容を確認し、公開する場合は `isPublished: true` に変更してください」と案内
- ローカル確認方法として `npm run dev`（nozo-blogディレクトリで `-p 3333`）を案内

## 記事のフォーマット

### フロントマター

```mdx
---
title: 記事タイトル（日本語、簡潔に）
isPublished: false
publishedAt: {Step 6で取得したISO 8601形式の日時}
---
```

**isPublished はデフォルトで `false`（下書き）**。

### 構造

1. **導入文**（1-3文）
   - なぜこの記事を書くのか、背景や動機
   - 「最近〜」「今回は〜」などで始める
2. **本文**
   - `##` で大きなセクション、`###` で小さなサブセクション
   - 必要に応じて箇条書きを活用
3. **コードブロック**（必要な場合）
   - 言語を必ず指定（```typescript、```bash など）
   - コードの後に何をしているか日本語で説明を追加
4. **まとめ/感想**（任意）
   - 学んだことや今後の展望
5. **参考資料**（任意）
   - 参考にしたリンクをマークダウンリンク形式でまとめる

## スタイルガイド

### 文体

- ですます調を使用
- 一人称は「自分」
- 実践ベースの表現（「〜してみました」「〜を試した」）
- 感想は柔らかい表現（「〜と思う」「〜なと感じた」）

### コードの説明

- コードブロックの後に、何をしているか日本語で説明を追加
- 重要なポイントや注意点があれば補足

### リンク

- 公式ドキュメントへのリンクは積極的に挿入
- URLだけでなくマークダウンリンク形式を使用

### 避けるべきこと

- 長すぎる導入文
- 抽象的な説明のみ（具体例を入れる）
- 会話のタイムスタンプやセッション固有の情報をそのまま残す

## ファイル命名規則

`{YYYY_MM_DD}_{slug}.mdx`

- 日付: コマンド実行時の日付（`date +"%Y_%m_%d"`）
- slug: 会話内容から考えた英語のケバブケース

### slugの決め方

記事の主題を最も適切に表す英語slugを考える。

**ルール**:

- ケバブケース（小文字、ハイフン区切り）
- 簡潔で内容がわかるものにする（長すぎない）
- 技術名やツール名はそのまま使用（例: `inversify`, `vitest`, `chakra-ui`, `nix`）

**パターン**:

- How-to系: `how-to-{動詞}-{対象}`（例: `how-to-use-inversify`）
- 設定系: `setup-{対象}`（例: `setup-logger-express`, `setup-ogp`）
- 移行系: `migrate-{from}-to-{to}` / `migrate-{対象}`（例: `migrate-chakra-ui-v3`）
- 学習系: `about-{対象}` / `learning-{対象}`
- 紹介系: `{ツール名}-{機能}`（例: `tanstack-table`, `prisma-seed`）
- 管理系: `manage-{対象}-with-{ツール}`（例: `manage-cli-tools-with-nix`）

## 重要な注意事項

1. **絶対パスで書き込む**: nozo-blog以外のディレクトリから実行されても動くよう、保存先は常に絶対パス
2. **下書きで作成**: `isPublished: false` をデフォルトとし、勝手に公開しない
3. **git操作はしない**: コミットやプッシュはユーザーに任せる
4. **会話固有情報の除去**: セッション固有のパスやタイムスタンプを記事に残さない
5. **日本語**: タイトル・本文は日本語で記述

## 使用例

```bash
# 今の会話の内容をそのまま記事化（カテゴリは programmings）
/write-nozo-article

# テーマを絞り込んで記事化
/write-nozo-article Nixでdotfilesを管理した話

# カテゴリとスラッグを指定
/write-nozo-article --category programmings --slug manage-dotfiles-with-nix
```

---

<user_requirement>
今の会話の内容を元に、以下の指示に従ってnozo-blogの記事を作成してください:
$ARGUMENTS
</user_requirement>
