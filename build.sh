#!/bin/bash
set -e

# Flutter SDK のクローン (特定のバージョンに固定して予期せぬエラーを防ぐ)
if [ ! -d "flutter" ]; then
  git clone --depth 1 --branch 3.29.0 https://github.com/flutter/flutter.git
fi

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
