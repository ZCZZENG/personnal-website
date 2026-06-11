#!/bin/zsh
# 双击启动本地预览：在项目目录起 HTTP 服务并自动打开足迹页
cd "$(dirname "$0")"
lsof -ti:8923 | xargs kill -9 2>/dev/null
(sleep 1 && open "http://localhost:8923/index.html") &
echo "本地预览已启动：http://localhost:8923/index.html"
echo "关闭预览：直接关掉这个终端窗口，或按 Ctrl+C"
python3 -m http.server 8923
