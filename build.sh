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

# Flutter の設定と診断
flutter config --enable-web
flutter doctor -v

# 依存関係の取得とコード生成
flutter pub get
flutter gen-l10n

# ビルド実行 (詳細ログを出力して原因を特定)
flutter build web --release -v
