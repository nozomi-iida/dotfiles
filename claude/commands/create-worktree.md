---
allowed-tools:
  - Bash
  - AskUserQuestion
  - WebFetch
description: NotionページのID(HR-XXXX形式)と要件テキストからブランチ名を生成し、git gtrでworktreeを作成する。「worktree作って」「WT切って」と言われた時に使用。
targets:
  - "*"
---

# Worktree作成コマンド

## 概要

NotionページのID(`HR-XXXX` 形式)と要件テキストを組み合わせてブランチ名を生成し、`git gtr new` でworktreeを作成する。
Notion URLが渡された場合はページからIDを抽出、URLが無い場合はユーザーに直接IDを問い合わせる。

## 引数フォーマット

```
$ARGUMENTS = [Notion URL(任意)] [要件の概要テキスト]
```

- Notion URLは **任意**。含まれていればページから `HR-XXXX` 形式のIDを抽出する。
- 要件の概要テキストは **必須**。タイトル(ケバブケース)生成に使う。無い場合はStep 1で対話補完する。

## 実行手順

### Step 1: 情報の収集

`$ARGUMENTS` を解析し、以下を確認する:

1. **Notion URL** (任意): `https://www.notion.so/...` や `https://*.notion.site/...` が含まれていれば抽出する。
2. **要件の概要** (必須): URLを除いた残りのテキストを要件として扱う。

**要件テキストが取れない場合のみ、AskUserQuestionで1回だけ質問する。**

### Step 2: ID(`HR-XXXX`形式)の取得

#### URLがある場合

1. まずURLのスラッグ部分から `HR-\d+` パターンを正規表現で抽出する(例: `https://notion.so/HR-6653-login-fix-abc123` → `HR-6653`)。
2. URLスラッグに見つからない場合は `WebFetch` でNotionページを取得し、本文・タイトルから `HR-\d+` パターンを抽出する。
3. それでも見つからない場合はAskUserQuestionでIDを質問する。

#### URLがない場合

AskUserQuestionで `HR-XXXX` 形式のIDを質問する。

### Step 3: ブランチ名の生成

#### 命名ルール

- **タイトル**: 要件の本質を表す簡潔な英語のケバブケース(例: `add-user-profile`, `login-validation`)。日本語要件は英訳して要約。最大40文字程度。
- **ID**: Step 2で取得した `HR-XXXX` 形式の文字列をそのまま使う。
- **フォーマット**:
  - **Notion URL ありの場合**: `{ID}/{title}` (例: `HR-6653/add-user-profile`)
  - **Notion URL なしの場合**: `{prefix}/{ID}-{title}` (例: `feature/HR-6653-add-user-profile`)
    - prefixは原則 `feature/`。明確にバグ修正・リファクタ・雑務の場合は `fix/`, `refactor/`, `chore/`。
- 全体で最大60文字以内が望ましい。

#### 例

| Notion URL | 要件 | 取得ID | ブランチ名 |
|-----------|------|--------|-----------|
| あり | ユーザープロフィール画面の追加 | `HR-6653` | `HR-6653/add-user-profile` |
| あり | ログインバリデーションのバグ修正 | `HR-7012` | `HR-7012/login-validation` |
| なし | API レスポンスのキャッシュ導入(ID: HR-7100) | `HR-7100` | `feature/HR-7100-api-response-cache` |
| なし | リファクタ: 古い認証ミドルウェア削除(ID: HR-7250) | `HR-7250` | `refactor/HR-7250-remove-old-auth` |

### Step 4: ユーザーへの確認

生成したブランチ名とIDの抽出元をユーザーに提示し、確認を取る:

```
ID: HR-6653 (URLから抽出 / ユーザー入力)
ブランチ名: HR-6653/add-user-profile
このブランチ名でworktreeを作成しますか？（変更があれば指定してください）
```

### Step 5: worktreeの作成

ユーザーの確認後、worktreeを作成する:

```bash
git gtr new {{ブランチ名}}
```

### Step 6: 結果の表示

- 作成されたworktreeのパスを表示
- Notion URLが指定されていた場合のみ再掲(作業時の参照用)

## 重要な注意事項

1. **質問は最小限**: 不足情報(要件テキスト/ID)のみまとめて1回で聞く
2. **ブランチ名はユーザー確認必須**: 自動生成した名前を勝手に使わない
3. **ID形式は `HR-\d+` 固定**: 他形式(数字のみ、UUID等)はサポートしない
4. **git gtr new の実行失敗時**: エラーメッセージを表示し、原因を説明する

## 使用例

```bash
# Notion URL + 要件 (URLからID抽出)
/create-worktree https://notion.so/HR-6653-xxx ユーザープロフィール画面の追加
# → HR-6653/add-user-profile

# Notion URL + 要件 (URLスラッグにID無し、本文から抽出)
/create-worktree https://notion.so/some-page-abc123 ログインバリデーションのバグ修正
# → HR-XXXX/login-validation

# 要件テキストのみ → IDを対話で質問
/create-worktree API レスポンスのキャッシュ導入
# → feature/HR-XXXX-api-response-cache

# 引数なし → 要件 と ID を対話で補完
/create-worktree
```

---

<user_requirement>
以下の引数でworktreeを作成してください:
$ARGUMENTS
</user_requirement>
