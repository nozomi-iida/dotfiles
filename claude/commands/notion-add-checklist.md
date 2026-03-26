---
description: git diffからNotionページの動作確認項目テーブルにテスト行を追加する（/notion-add-checklist）。NotionのURLを引数に取る。tsumiki:notion-checklistとは異なり、要件ファイルではなくgit diffからテスト項目を生成し、既存テーブルに行を追記する。MCPツールではtable_rowの追加が不可のためNotion APIを直接呼び出す点に注意。
---

# Notionテーブルへの動作確認項目追加

## Role

あなたはソフトウェアテスト設計の専門家です。git diffを分析し、変更内容に対する網羅的な動作確認項目を設計できます。

## 引数フォーマット

```
$ARGUMENTS = <notion_url> [--base <branch>]
```

- `notion_url` (必須): NotionページのURL
- `--base` (任意): 差分を取得するベースブランチ（デフォルト: `develop`）

## 実行手順

### Step 1: 引数の解析

`$ARGUMENTS` から Notion URL とベースブランチを抽出する。

Notion URLからページIDを抽出する:
- `https://www.notion.so/xxx/Title-{page_id}` → ハイフン区切りIDの末尾32文字
- UUIDフォーマット（8-4-4-4-12）に変換

### Step 2: git diffの取得と分析

```bash
git diff origin/{base}...HEAD --stat
git diff origin/{base}...HEAD
git log origin/{base}..HEAD --oneline --no-merges
```

変更内容を分析し、以下を特定する:
- 新機能・修正された機能
- 影響を受ける画面・コンポーネント
- 正常系・異常系・境界値
- デグレリスクのある既存機能

### Step 3: 動作確認項目の設計

以下の観点でテスト項目を設計する:

1. **正常系**: 変更した機能が期待通り動作するか
2. **異常系**: エラーケース、バリデーション
3. **境界値**: 上限・下限、空値
4. **デグレ確認**: 変更による既存機能への影響
5. **UX**: 画面遷移、表示、レスポンシブ

各項目は以下の9カラムで設計する:

| カラム | 説明 |
|--------|------|
| No. | 連番 |
| 画面 | テスト対象の画面名 |
| 条件1 | テスト条件（主条件） |
| 条件2 | テスト条件（副条件、なければ空） |
| 条件3 | テスト条件（追加条件、なければ空） |
| ユーザー操作 | ユーザーが行う操作 |
| 期待される挙動 | 期待される結果 |
| デグレチェック？ | デグレ確認項目の場合「○」、そうでなければ空 |
| OK / NG | 空（テスト実施時に記入） |

### Step 4: Notionページの既存テーブルを特定

1. `mcp__notionMcp__API-get-block-children` でページのブロック一覧を取得
2. `heading_2` で「動作確認項目」を探す
3. その直後の `table` ブロックのIDを取得
4. テーブルの子ブロック（既存行）を取得し、既存のNo.の最大値を確認

### Step 5: テーブルに行を追加

**重要**: Notion MCPツール（`mcp__notionMcp__API-patch-block-children`）は `table_row` ブロックタイプをサポートしていないため、Notion APIを直接呼び出す。

#### 5-1: APIトークンの取得

```bash
python3 -c "
import json
with open('/home/nozomi/ghq/github.com/asuene/asuene-career/.mcp.json') as f:
    d = json.load(f)
headers_json = d['mcpServers']['notionMcp']['env']['OPENAPI_MCP_HEADERS']
headers = json.loads(headers_json)
print(headers['Authorization'])
"
```

#### 5-2: テーブル行の追加

```bash
NOTION_TOKEN="$(上記で取得したトークン)"
TABLE_ID="{テーブルブロックID}"

curl -s -X PATCH "https://api.notion.com/v1/blocks/$TABLE_ID/children" \
  -H "Authorization: $NOTION_TOKEN" \
  -H "Notion-Version: 2022-06-28" \
  -H "Content-Type: application/json" \
  -d @/tmp/notion_rows.json
```

#### 5-3: JSONペイロードの形式

```json
{
  "children": [
    {
      "type": "table_row",
      "table_row": {
        "cells": [
          [{"type": "text", "text": {"content": "1"}}],
          [{"type": "text", "text": {"content": "画面名"}}],
          [{"type": "text", "text": {"content": "条件1"}}],
          [{"type": "text", "text": {"content": "条件2"}}],
          [{"type": "text", "text": {"content": "条件3"}}],
          [{"type": "text", "text": {"content": "操作"}}],
          [{"type": "text", "text": {"content": "期待結果"}}],
          [{"type": "text", "text": {"content": "○ or 空"}}],
          []
        ]
      }
    }
  ]
}
```

**注意点**:
- セルが空の場合は `[]` を使用
- No.は既存行の最大値+1から開始
- Notion APIは1回のリクエストで100行まで追加可能
- 一時ファイル(`/tmp/notion_rows.json`)は処理完了後に削除すること

### Step 6: 結果の表示

追加した項目の一覧をマークダウンテーブルで表示し、Notionページへのリンクを提示する。

## テンプレートの空行について

既存テーブルに空の行（No.だけ入っている行）がある場合は、それらを上書きせず、テーブルの末尾に新しい行として追加する。

## 引数

$ARGUMENTS
