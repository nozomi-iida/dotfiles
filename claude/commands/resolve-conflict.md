---
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - AskUserQuestion
description: マージ/リベース/チェリーピック中のコンフリクトを解析し、両サイドの変更を読み取って解消案を提示・適用する。「コンフリクト解消して」「conflict直して」と言われた時に使用。
targets:
  - "*"
---

# コンフリクト解消コマンド

## 概要

merge / rebase / cherry-pick / revert / stash pop などで発生したコンフリクトを検出し、両サイドの変更（HEAD と MERGE_HEAD/REBASE_HEAD など）を読み取った上で解消案を提示して適用する。解消後はステージングまで行い、続行コマンド（`git merge --continue` など）を案内する。コミットや `--continue` の実行はユーザーに委ねる。

## 引数フォーマット

```
$ARGUMENTS = [補足指示テキスト(任意)]
```

- 補足指示があれば解消方針のヒントとして使う（例: `両方残して`, `HEAD優先`, `incoming優先`, `Aファイルだけ手動でやるからスキップ`）。
- 引数なしでも動作する（diff と両サイドから自動判断）。

## 実行手順

### Step 1: コンフリクト状態の検出

以下のコマンドで状況を取得する:

```bash
git status --short
git ls-files -u
```

判定:

- `git ls-files -u` の出力が空 → **コンフリクトなし**。「現在コンフリクト中のファイルはありません」と表示して終了。
- 進行中の操作を以下で判定する:
  - `.git/MERGE_HEAD` 存在 → merge 中
  - `.git/rebase-merge/` または `.git/rebase-apply/` 存在 → rebase 中
  - `.git/CHERRY_PICK_HEAD` 存在 → cherry-pick 中
  - `.git/REVERT_HEAD` 存在 → revert 中
  - いずれもなし → stash pop / patch apply 由来などの可能性あり。状況を表示してユーザーに知らせる。

検出した操作種別と、`git status --short` のコンフリクトマーカー（`UU`, `AA`, `DD`, `AU`, `UA`, `DU`, `UD`）を一覧で表示する。

### Step 2: 各ファイルの両サイドを読み取る

コンフリクトファイルごとに以下を取得する:

```bash
# 三者の内容を確認
git show :1:<file>   # base (共通祖先)
git show :2:<file>   # ours (HEAD側)
git show :3:<file>   # theirs (MERGE_HEAD等)
```

- `UU` (両方変更): 上記3バージョンを取得して差分を比較
- `AA` (両方追加): base なし。2 と 3 を比較
- `DU` / `UD` (片方削除・片方変更): 削除と変更の意図を判断するため、削除側のログ（`git log --oneline -1 :3:<file>` 等）も参考にする
- `DD` (両方削除): 通常はそのまま削除で OK

ファイル本体の `<<<<<<<` / `=======` / `>>>>>>>` マーカーも Read ツールで確認し、コンフリクトしている**範囲**と、その前後のコンテキストを把握する。

### Step 3: 解消方針の決定

各コンフリクトについて、以下の優先順位で方針を立てる:

1. **補足指示があればそれに従う**（例: 「HEAD優先」なら `git checkout --ours <file>` 相当）
2. **論理的にマージ可能か判断する**:
   - 両サイドが**異なる関数/import/設定キー**を追加しているだけ → 両方残す
   - 両サイドが**同じ関数の異なる引数**を変更しているなど意味的衝突 → ユーザー確認が必要
   - リネーム vs 編集、削除 vs 編集 → ユーザー確認が必要
3. **自動判断が難しいケース**は無理に解消せず、Step 4 でユーザーに方針を聞く

#### よくあるパターンの扱い

| パターン | 推奨解消 |
|---------|---------|
| 両サイドが別行に import 追加 | 両方残してアルファベット順に並び替え |
| package.json の依存追加が衝突 | 両方残す。バージョン違いは新しい方 or ユーザー確認 |
| lock ファイル（package-lock.json, yarn.lock, pnpm-lock.yaml, Cargo.lock 等） | 解消せずに `Step 6` で再生成を案内する |
| 同じ行を両サイドが別の値に変更 | ユーザー確認必須 |
| マイグレーションファイルの番号衝突 | ユーザー確認必須（採番ルールに依存） |

### Step 4: ユーザーへの確認

以下の形式で AskUserQuestion 1回でまとめて確認する:

```
進行中の操作: merge (origin/main を取り込み中)
コンフリクトファイル: 3件

1. src/foo.ts (UU)
   - ours: getUser に async 化
   - theirs: getUser に引数 token を追加
   - 提案: 両方適用して `async getUser(token)` にする

2. src/bar.ts (UU)
   - 別行のimport追加同士 → 両方残す（自動マージ可）

3. package-lock.json (UU)
   - 自動解消はせず、依存解消後に再生成を推奨

このまま進めてよいですか？（個別に方針を変えたい場合は番号で指示してください）
```

- ユーザーの返答に従って方針を確定する。
- 方針が定まらないファイルは**スキップ**として残し、ステージしない（後で手動対応してもらう）。

### Step 5: 解消の適用

確定した方針で各ファイルを解消する:

- **テキストファイルの内容マージ**: Read で確認 → Edit でコンフリクトマーカーを除去しつつ目的の内容に書き換え
- **片側採用**:
  - ours採用: `git checkout --ours <file>`
  - theirs採用: `git checkout --theirs <file>`
- **削除採用**: `git rm <file>`
- **lock ファイル**: 解消せずに Step 6 で再生成案内のみ行う（ステージもしない）

各ファイル解消後、必ずステージングする:

```bash
git add <file>
```

### Step 6: 結果の表示と次のアクション案内

以下を表示する:

```
解消済み: src/foo.ts, src/bar.ts
スキップ: package-lock.json (要再生成: `npm install` 後に `git add package-lock.json`)
未対応:   src/baz.ts (方針未確定 → 手動で解消してください)
```

進行中の操作に応じて続行コマンドを案内する（**実行はしない**）:

| 操作 | 続行コマンド | 中止コマンド |
|------|------------|------------|
| merge | `git merge --continue` | `git merge --abort` |
| rebase | `git rebase --continue` | `git rebase --abort` |
| cherry-pick | `git cherry-pick --continue` | `git cherry-pick --abort` |
| revert | `git revert --continue` | `git revert --abort` |
| stash pop | `git commit` 後に必要なら手動で stash drop | `git checkout -- .` 等 |

## 重要な注意事項

1. **`--continue` / `--abort` は実行しない**: 解消とステージングまで。最終判断はユーザーに委ねる。
2. **コミットしない**: merge --continue 等が暗黙にコミットを作るため、ユーザーが意図したタイミングで実行できるよう、こちらからは触らない。
3. **lock ファイルは原則自動解消しない**: 矛盾を抱えたまま進むリスクが高いため、再生成を案内する。
4. **判断が割れたら必ず確認**: 同じ行を別々の値に変更している場合や、削除 vs 編集は推測しない。
5. **質問は最小限**: Step 4 の方針確認 1 回にまとめる。途中で何度も聞かない。
6. **`git checkout --ours/--theirs` の方向に注意**: rebase 中は ours/theirs が直感と逆（ours = 取り込み先 = upstream）になる点を意識し、必要なら明示する。
7. **マーカー残存チェック**: 解消後に `git grep -nE '^(<{7}|={7}|>{7}) '` でマーカーが残っていないか確認する。

## 使用例

```bash
# 自動判断で進める
/resolve-conflict

# HEADを優先する方針を補足
/resolve-conflict 全部HEAD優先で

# 特定ファイルだけ手動でやる旨を伝える
/resolve-conflict migrationsは触らないで、それ以外は両方残す方向で

# incoming(取り込み側)優先
/resolve-conflict theirs優先
```

---

<user_requirement>
以下の補足指示（任意）を参考に、現在発生しているコンフリクトを解析・解消してください:
$ARGUMENTS
</user_requirement>
