# Foundation Agents

一个基于Flutter 3.x的现代化应用程序，采用Clean Architecture和BLoC模式构建。

## 🚀 特性

- **Clean Architecture**: 清晰的分层架构，易于维护和扩展
- **BLoC状态管理**: 使用flutter_bloc进行状态管理
- **Material 3设计**: 现代化的UI设计系统
- **依赖注入**: 使用GetIt进行依赖管理
- **错误处理**: 完善的错误处理机制，使用Either类型
- **路由管理**: 使用GoRouter进行路由管理
- **测试支持**: 完整的测试结构支持

## 🏗️ 项目结构

```
lib/
├── core/                    # 核心功能
│   ├── constants/          # 常量定义
│   ├── theme/              # 主题配置
│   ├── utils/              # 工具类
│   ├── widgets/            # 通用组件
│   └── di/                 # 依赖注入
├── features/               # 功能模块
│   └── home/              # Home功能
│       ├── data/          # 数据层
│       ├── domain/        # 领域层
│       └── presentation/  # 表现层
├── l10n/                  # 国际化
└── main.dart              # 应用入口
```

## 🛠️ 技术栈

- **Flutter**: 3.x
- **状态管理**: flutter_bloc
- **依赖注入**: get_it
- **路由**: go_router
- **错误处理**: dartz (Either类型)
- **测试**: bloc_test, mockito

## 📱 功能

- 显示欢迎消息
- 支持消息更新
- 响应式设计
- 深色/浅色主题切换
- 错误处理和重试机制

## 🚀 快速开始

### 环境要求

- Flutter 3.10.0 或更高版本
- Dart 3.0.0 或更高版本

### 安装依赖

```bash
flutter pub get
```

### 运行应用

```bash
flutter run
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/unit/home_bloc_test.dart
```

## 🧪 测试

项目包含完整的测试结构：

- **单元测试**: 测试业务逻辑
- **Widget测试**: 测试UI组件
- **集成测试**: 测试完整功能

## 🎨 主题

应用支持Material 3设计系统，包含：

- 浅色主题
- 深色主题
- 自动主题切换
- 自定义颜色方案

## 📁 文件说明

### 核心文件

- `lib/main.dart`: 应用入口点
- `lib/core/di/dependency_injection.dart`: 依赖注入配置
- `lib/core/theme/app_theme.dart`: 主题配置

### 功能模块

- `lib/features/home/`: Home功能模块
  - `domain/`: 业务逻辑和实体
  - `data/`: 数据访问和模型
  - `presentation/`: UI和状态管理

## 🔧 开发指南

### 添加新功能

1. 在`features/`目录下创建新模块
2. 实现domain、data、presentation层
3. 在依赖注入中注册新组件
4. 添加相应的测试

### 代码规范

- 使用有意义的命名
- 遵循Flutter官方代码规范
- 添加适当的注释
- 保持代码简洁

## 📄 许可证

本项目采用MIT许可证。

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📞 联系方式

如有问题，请通过以下方式联系：

- 提交GitHub Issue
- 发送邮件至项目维护者

---

**注意**: 这是一个示例项目，展示了Flutter应用的最佳实践。在实际项目中，请根据具体需求进行调整。
