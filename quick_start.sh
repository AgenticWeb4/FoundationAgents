#!/bin/bash

echo "🚀 Foundation Agents 快速启动脚本"
echo "========================================"
echo

echo "🔍 检查 Flutter 环境..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装或不在 PATH 中"
    echo "📝 请先安装 Flutter SDK"
    echo "🌐 下载地址: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter 环境检查通过"
echo

echo "📦 获取项目依赖..."
if ! flutter pub get; then
    echo "❌ 依赖获取失败"
    exit 1
fi

echo "✅ 依赖获取成功"
echo

echo "🧪 运行项目测试..."
if flutter test; then
    echo "✅ 所有测试通过"
else
    echo "⚠️ 测试运行完成，但可能有失败项"
fi

echo
echo "📱 启动应用..."
echo "💡 提示: 按 'r' 进行热重载，按 'R' 进行热重启，按 'q' 退出"
echo

flutter run
