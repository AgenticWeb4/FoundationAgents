@echo off
chcp 65001 >nul
echo 🚀 Foundation Agents 快速启动脚本
echo ========================================
echo.

echo 🔍 检查 Flutter 环境...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter 未安装或不在 PATH 中
    echo 📝 请先安装 Flutter SDK
    echo 🌐 下载地址: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo ✅ Flutter 环境检查通过
echo.

echo 📦 获取项目依赖...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ 依赖获取失败
    pause
    exit /b 1
)

echo ✅ 依赖获取成功
echo.

echo 🧪 运行项目测试...
flutter test
if %errorlevel% neq 0 (
    echo ⚠️ 测试运行完成，但可能有失败项
) else (
    echo ✅ 所有测试通过
)

echo.
echo 📱 启动应用...
echo 💡 提示: 按 'r' 进行热重载，按 'R' 进行热重启，按 'q' 退出
echo.

flutter run

pause
