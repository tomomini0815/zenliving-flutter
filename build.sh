#!/bin/bash

# Flutter SDK のクローン (stable ブランチ)
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable
fi

# パスを通す
export PATH="$PATH:`pwd`/flutter/bin"

# Flutter の設定とビルド
flutter config --enable-web
flutter build web --release
