#!/bin/bash
set -e

# クリーンアップ: 壊れたキャッシュを避けるために毎回クリーンインストール
rm -rf flutter

# Flutter SDK のクローン
git clone https://github.com/flutter/flutter.git -b stable

# パスを通す
export PATH="$PATH:`pwd`/flutter/bin"

echo "Current Flutter Version:"
flutter --version

# Dartのメモリ制限を設定し、Vercelのメモリ上限(OOM)による強制終了を回避
export DART_VM_OPTIONS="--old_gen_heap_size=1536"

# Flutter の設定
flutter config --enable-web

# プロジェクトのクリーンアップ（Vercelキャッシュとの競合防止）
flutter clean

# 依存関係の取得とコード生成
flutter pub get
flutter gen-l10n

# ビルド実行（最もメモリを消費する機能であるアイコンのツリーシェイキングを無効化）
flutter build web --release --no-tree-shake-icons
