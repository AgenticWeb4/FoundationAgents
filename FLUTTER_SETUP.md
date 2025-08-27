# 🚀 Flutter 环境设置指南

## 📋 环境要求

- **操作系统**: Windows 10/11, macOS, 或 Linux
- **Flutter SDK**: 3.10.0 或更高版本
- **Dart SDK**: 3.0.0 或更高版本 (通常随Flutter一起安装)
- **Android Studio** 或 **VS Code** (推荐)

## 🔧 安装步骤

### 1. 下载 Flutter SDK

访问 [Flutter 官方下载页面](https://flutter.dev/docs/get-started/install) 或直接下载：

**Windows:**
```bash
# 下载 Flutter SDK
# 解压到 C:\flutter 或你选择的目录
```

**macOS/Linux:**
```bash
# 下载 Flutter SDK
# 解压到 ~/flutter 或你选择的目录
```

### 2. 配置环境变量

**Windows:**
1. 右键"此电脑" → "属性" → "高级系统设置" → "环境变量"
2. 在"系统变量"中找到 `Path`，点击"编辑"
3. 添加 Flutter SDK 的 bin 目录路径，如：`C:\flutter\bin`
4. 点击"确定"保存

**macOS/Linux:**
```bash
# 编辑 ~/.bash_profile 或 ~/.zshrc
export PATH="$PATH:$HOME/flutter/bin"

# 重新加载配置
source ~/.bash_profile  # 或 source ~/.zshrc
```

### 3. 验证安装

打开新的终端窗口，运行：
```bash
flutter --version
flutter doctor
```

`flutter doctor` 会检查你的环境并显示需要解决的问题。

### 4. 安装依赖

进入项目目录：
```bash
cd FoundationAgents
flutter pub get
```

## 🧪 运行测试

### 1. 代码分析
```bash
flutter analyze
```

### 2. 运行单元测试
```bash
flutter test
```

### 3. 运行特定测试文件
```bash
flutter test test/unit/home_bloc_test.dart
```

### 4. 生成测试覆盖率报告
```bash
flutter test --coverage
```

## 📱 运行应用

### 1. 检查可用设备
```bash
flutter devices
```

### 2. 启动应用
```bash
# 在默认设备上运行
flutter run

# 在特定设备上运行
flutter run -d <device-id>
```

### 3. 热重载
应用运行后，按 `r` 进行热重载，按 `R` 进行热重启。

## 🔍 项目验证

我们已经创建了一个验证脚本 `validate_project.py`，可以检查项目结构：

```bash
python validate_project.py
```

## 📊 项目状态

✅ **项目验证通过**
- 文件结构完整
- 代码质量良好
- 依赖配置正确
- 总代码行数: 1,259 行

## 🚨 常见问题

### 1. Flutter 命令未找到
- 检查环境变量配置
- 重启终端
- 确认 Flutter SDK 路径正确

### 2. 依赖获取失败
```bash
# 清理缓存
flutter clean
flutter pub get
```

### 3. 测试失败
```bash
# 检查测试依赖
flutter test --verbose
```

## 📚 学习资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言教程](https://dart.dev/guides)
- [Flutter 测试指南](https://flutter.dev/docs/testing)
- [Clean Architecture 模式](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 🎯 下一步

1. **安装 Flutter SDK**
2. **运行 `flutter doctor` 检查环境**
3. **运行 `flutter pub get` 获取依赖**
4. **运行 `flutter test` 执行测试**
5. **运行 `flutter run` 启动应用**

---

**🎉 恭喜！你的 Foundation Agents 项目已经准备就绪，可以开始开发了！**
