# Ubuntuをセットアップするときに手動で設定するところ
## fcitixのIMEの切り替えを左右のSuperキーでできるようにする

## マウスホイールを逆にする

## fcitxをtweaksのスタートアプリケーションに追加

## tweaksでemacsのように文字を入力できるように設定

## GitHubでsshキー認証できるようにする
`ssh-keygen -t ed25519 -f ~/.ssh/github`
`cat github.pub`の内容をGitHubにコピペ
`ssh -i ~/.ssh/github -T git@github.com`
`ssh-add ~/.ssh/github`
