#!/bin/bash
set -e

echo "Vercelのメモリ上限(OOM)を回避するため、Vercel上でのビルドはスキップします"
echo "GitHubにプッシュされたローカルでのビルド済み生成物 (build/web) をそのままホスティングします"
exit 0
