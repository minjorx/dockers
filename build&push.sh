#!/usr/bin/env bash

# 检查参数数量
if [ $# -ne 3 ]; then
    echo "❌ 用法: $0 <Dockerfile路径> <镜像名> <版本号>"
    echo "💡 示例: $0 DockerfileAlpineOpenJdk25 minjor/alpine-openjdk25 1.0.0"
    exit 1
fi

DOCKERFILE="$1"
IMAGE_NAME="$2"
VERSION="$3"

# 检查 Dockerfile 是否存在
if [ ! -f "$DOCKERFILE" ]; then
    echo "❌ Dockerfile 不存在: $DOCKERFILE"
    exit 1
fi

FULL_IMAGE="$IMAGE_NAME:$VERSION"

echo "📦 使用 $DOCKERFILE 构建镜像: $FULL_IMAGE"

# 构建
docker build -f "$DOCKERFILE" -t "$FULL_IMAGE" . || {
    echo "❌ 构建失败！"
    exit 1
}

echo "🚀 推送镜像: $FULL_IMAGE"
docker push "$FULL_IMAGE" || {
    echo "❌ 推送失败！请确保已运行 'docker login' 并有权限推送至 $IMAGE_NAME。"
    exit 1
}

echo "✅ 成功推送: $FULL_IMAGE"