#!/bin/bash

echo "Javaのインストールを開始します..."
sudo apt update
# デフォルトのJava（OpenJDK）をインストール
sudo apt install -y default-jdk default-jre
# インストール確認
java_version=$(java -version 2>&1 | head -n 1)
echo "インストールされたJavaのバージョン:"
java -version
# JAVA_HOMEの設定
JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
echo "JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/environment
echo "Javaのインストールが完了しました"
# 環境変数を現在のセッションに反映
source /etc/environment
