#!/usr/bin/env bash

# 检查是否提供了版本号
if [ $# -eq 0 ]; then
    echo "❌ 用法: $0 <版本号>"
    echo "💡 示例: $0 1.0.0"
    exit 1
fi

VERSION="$1"
IMAGE_NAME="minjor/alpine-openjdk25"

echo "📦 构建镜像: $IMAGE_NAME:$VERSION"

# 构建镜像
docker build -f DockerfileAlpineOpenJdk25 -t "$IMAGE_NAME:$VERSION" . || {
    echo "❌ 构建失败！"
    exit 1
}

# 可选：打上 latest 标签（取消注释下一行即可启用）
# docker tag "$IMAGE_NAME:$VERSION" "$IMAGE_NAME:latest"

echo "🚀 推送镜像: $IMAGE_NAME:$VERSION"
docker push "$IMAGE_NAME:$VERSION" || {
    echo "❌ 推送失败！请确保已执行 'docker login' 并拥有仓库权限。"
    exit 1
}

# 如果启用了 latest 标签，也一并推送
# echo "🚀 推送 latest 标签..."
# docker push "$IMAGE_NAME:latest"

echo "✅ 成功推送: $IMAGE_NAME:$VERSION"