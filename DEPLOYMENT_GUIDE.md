# Vercel デプロイメントガイド & トラブルシューティング

## 概要
ZenLivingアプリをVercelのような無料枠（Hobbyプラン）のホスティングサービスにデプロイする際、Flutter SDKによるWebコンパイルタスクが高負荷になり、メモリ制限（OOM: Out Of Memory）でプロセスが強制終了（SIGKILL・exit code 1等）される問題が発生します。  
本ガイドでは、このエラーを回避し、確実かつ高速にデプロイを行うための「ローカルビルド＆プッシュ方式」について記録しています。

---

## 発生したエラーの症状
Vercelのデプロイ時の `Building` ログにて、以下のような出力の直後にビルドが強制終了します。
```text
#19     AppContext.run.<anonymous closure> (package:flutter_tools/src/base/context.dart:154:19)
<asynchronous suspension>
#20     main (package:flutter_tools/executable.dart:103:3)
<asynchronous suspension>

Error: Failed to compile application for the Web.
Error: Command "bash build.sh" exited with 1
```
* **原因:** FlutterのWebビルド（特にdart2jsやWASMの最適化処理）がVercelのメモリ上限（通常1GB前後）を突破し、コンテナから強制シャットダウンを受けるため。

---

## 回避策：ローカルビルド＆完成品プッシュ方式
Vercel上でコンパイルを行わず、開発環境（ローカルPC）でビルドした完成品データ（`build/web`）を直接ホスティングします。

### 設定の前提条件（現在の対応内容）
1. `build.sh` は以下のように中身を空（`exit 0`）にし、Vercel側でのビルド実行をスキップさせています。
```bash
#!/bin/bash
set -e
echo "Vercelのメモリ上限を回避するため、ローカルビルド済みのファイルをホスティングします"
exit 0
```
2. Vercelの `Output Directory` の設定は `build/web` となっています（`vercel.json` 準拠）。

---

## 今後のデプロイ手順（運用時の注意点）
ソースコード（Dartファイルや他言語対応ファイル）を変更し、**本番環境（Vercel）に最新の変更を反映させたい場合**は、以下の手順でデプロイを行ってください。

### 1. 手元（ローカル）でビルドする
ターミナルを開き、以下のコマンドを実行してWeb用の最適化されたファイル群を生成します。
```bash
flutter build web --release
```

### 2. 生成されたファイルを強制的にGitに追加する
`.gitignore`の設定により通常は `build/` フォルダはGitの監視対象外となっています。これを無視して強制的に追跡させるためにフェッチオプション(`-f`)を利用します。
```bash
git add -f build/web
```

### 3. 他の修正と合わせてコミット・プッシュする
```bash
git add .
git commit -m "feat: [変更内容] と 最新のビルドファイルの更新"
git push
```

プッシュ完了後、数秒〜数十秒でVercelがGitHubの変更を検知し、`build/web` の中身をそのままインターネット上に公開します！
