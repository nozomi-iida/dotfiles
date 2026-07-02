---
allowed-tools:
  - Read
  - Write
  - Glob
  - Bash
  - AskUserQuestion
description: 新しいnozo-blog記事の「タイトル・ファイル(slug)・目次」を決めて、本文が空のmdxを作成する。「記事の方向性を決めたい」「記事の目次を作って」と言われた時に使用。本文を書くのは /write-nozo-article。
targets:
  - "*"
---

# nozo-blog 記事プランニングコマンド

## 概要

新しいnozo-blog記事の**骨組みを作る**コマンド。会話の内容やヒアリングをもとに、

1. **記事のタイトルを決める**
2. **タイトル(slug)からファイルを作成する**
3. **記事の目次(見出し)を決める**

ここまでを行う。**本文はまだ書かない。** 目次だけが入った本文が空のmdxを、実際の記事の保存先に直接作成する。本文の執筆は別コマンド `/write-nozo-article` が担当し、この骨組みを埋めていく。

**nozo-blogのパス**: `/home/nozomi/ghq/github.com/nozomi-iida/nozo-blog`
**記事の保存先**: `{nozo-blog}/src/articles/{category}/{YYYY_MM_DD}_{slug}.mdx`

## 引数フォーマット

```
$ARGUMENTS = [--category programmings|poems|atcoder] [--title タイトル] [--slug slug] [記事にしたいテーマ・補足]
```

- `--category <name>`: カテゴリ（未指定時は `programmings` を提案）
- `--title <title>`: タイトル（未指定時はヒアリング結果から決める）
- `--slug <slug>`: 英語スラッグ（未指定時はタイトルから決める）
- その他: 記事にしたいテーマや補足

## 実行手順

### Step 1: nozo-blogの存在確認

```bash
test -d /home/nozomi/ghq/github.com/nozomi-iida/nozo-blog/src/articles && echo OK
```

存在しない場合はエラーを表示して終了する。

### Step 2: テーマ・方向性のヒアリング

**決め打ちせず、会話の内容を踏まえて方向性の案を提示し、ユーザーと擦り合わせる。** `AskUserQuestion` などで以下を確認する（会話や `$ARGUMENTS` から既に明らかな項目は省略してよい）。

- **テーマ / 主題**: 何について書くか。会話に複数の話題がある場合はどれを記事にするか
- **カテゴリ**: `programmings` / `poems` / `atcoder`（未指定なら `programmings` を提案）
- **記事の狙い・粒度**: How-to（手順重視）か、学び・感想寄りか、紹介寄りか

### Step 3: タイトルを決める（ゴール1）

内容を表す簡潔な日本語タイトルを決める。案を提示してユーザーに確認する（`--title` 指定時はそれを採用）。

### Step 4: slugを決める（ゴール2の準備）

タイトル・主題を表す英語のslugを決める。

- ケバブケース（小文字、ハイフン区切り）、簡潔に
- 技術名・ツール名はそのまま使用（例: `inversify`, `vitest`, `nix`）
- パターン: `how-to-{動詞}-{対象}` / `setup-{対象}` / `migrate-{対象}` / `about-{対象}` / `{ツール名}-{機能}` / `manage-{対象}-with-{ツール}`

#### 重複チェック

```bash
ls /home/nozomi/ghq/github.com/nozomi-iida/nozo-blog/src/articles/{category}/ | grep {slug}
```

同じslugの記事が既にある場合はユーザーに確認する。

### Step 5: 目次を決める（ゴール3）

記事の目次（`##` 見出しレベルのアウトライン）を決める。狙いに沿って、導入→本文→まとめ の流れになるよう構成する。各見出しで何を書くかのメモを1行添えて、ユーザーに提示・確認する。

### Step 6: ファイルの作成（ゴール2）

公開日時とファイル名の日付を取得する。

```bash
date -u +"%Y-%m-%dT%H:%M:%S.000Z"   # publishedAt 用
date +"%Y_%m_%d"                      # ファイル名の日付
```

`{nozo-blog}/src/articles/{category}/{YYYY_MM_DD}_{slug}.mdx` を、**フロントマター + 目次(見出し)だけ**の状態で作成する。本文はまだ書かず、各見出しの下に「何を書くか」のメモを MDX コメント `{/* ... */}` で残しておく（`/write-nozo-article` がこれを見て本文を埋める）。

```mdx
---
title: 記事タイトル
isPublished: false
publishedAt: {Step 6で取得したISO 8601形式の日時}
---

{/* 目次だけの骨組み。本文は /write-nozo-article で埋める */}

## セクション1の見出し

{/* ここに書く内容のメモ */}

## セクション2の見出し

{/* ここに書く内容のメモ */}

## まとめ

{/* ここに書く内容のメモ */}
```

### Step 7: 結果の表示と次のアクション案内

- 作成したファイルの絶対パスを表示
- 決めたタイトル・slug・目次を提示
- `isPublished: false`（下書き）で骨組みを作ったことを通知
- 「本文を書く場合は `/write-nozo-article` を実行してください（このファイルの目次を埋めます）」と案内

## 重要な注意事項

1. **本文は書かない**: このコマンドのゴールは「タイトル・ファイル・目次」まで。本文の執筆は `/write-nozo-article`
2. **ヒアリング優先**: 決め打ちせず、タイトル・目次を擦り合わせてから作成する
3. **下書きで作成**: `isPublished: false` をデフォルトとし、勝手に公開しない
4. **絶対パスで書き込む**: 保存先は常に絶対パス
5. **git操作はしない**: コミットやプッシュはユーザーに任せる
6. **日本語**: タイトル・見出しは日本語で記述

## 使用例

```bash
# 会話の内容からタイトル・目次を決めて骨組みを作る
/plan-nozo-article

# テーマを指定して骨組みを作る
/plan-nozo-article herdrを使ってみた感想

# カテゴリとslugを指定
/plan-nozo-article --category programmings --slug how-to-use-herdr
```

---

<user_requirement>
以下の指示を踏まえ、新しいnozo-blog記事のタイトル・ファイル(slug)・目次を決めて、本文が空のmdxを作成してください:
$ARGUMENTS
</user_requirement>
