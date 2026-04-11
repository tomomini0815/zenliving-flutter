#!/bin/bash
set -e

# Flutter SDK のクローン (shallow clone で容量削減と高速化)
if [ ! -d "flutter" ]; then
  git clone --depth 1 https://github.com/flutter/flutter.git -b stable
fi

# パスを通す
export PATH="$PATH:`pwd`/flutter/bin"

# Flutter の設定と診断
flutter config --enable-web
flutter doctor

# 依存関係の取得とコード生成
flutter pub get
flutter gen-l10n

# ビルド実行
flutter build web --release
