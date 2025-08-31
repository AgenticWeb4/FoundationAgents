#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Foundation Agents 项目验证脚本
用于验证Flutter项目的代码结构和质量
"""

import os
import re
from pathlib import Path

def check_file_structure():
    """检查项目文件结构"""
    print("🔍 检查项目文件结构...")
    
    required_files = [
        "pubspec.yaml",
        "lib/main.dart",
        "lib/core/constants/app_constants.dart",
        "lib/core/theme/app_theme.dart",
        "lib/core/utils/error_handler.dart",
        "lib/core/widgets/common_widgets.dart",
        "lib/core/di/dependency_injection.dart",
        "lib/features/home/domain/entities/home_entity.dart",
        "lib/features/home/domain/repositories/home_repository.dart",
        "lib/features/home/domain/usecases/get_home_message.dart",
        "lib/features/home/data/models/home_model.dart",
        "lib/features/home/data/repositories/home_repository_impl.dart",
        "lib/features/home/presentation/bloc/home_bloc.dart",
        "lib/features/home/presentation/pages/home_page.dart",
        "lib/features/home/presentation/widgets/home_widget.dart",
        "test/unit/home_bloc_test.dart",
        "lib/l10n/app_zh.arb",
        "lib/l10n/app_en.arb",
        "README.md"
    ]
    
    missing_files = []
    for file_path in required_files:
        if not os.path.exists(file_path):
            missing_files.append(file_path)
    
    if missing_files:
        print(f"❌ 缺少以下文件:")
        for file_path in missing_files:
            print(f"   - {file_path}")
        return False
    else:
        print("✅ 所有必需文件都存在")
        return True

def check_dart_imports():
    """检查Dart文件的import语句"""
    print("\n🔍 检查Dart文件import语句...")
    
    dart_files = [
        "lib/main.dart",
        "lib/core/constants/app_constants.dart",
        "lib/core/theme/app_theme.dart",
        "lib/core/utils/error_handler.dart",
        "lib/core/widgets/common_widgets.dart",
        "lib/core/di/dependency_injection.dart",
        "lib/features/home/domain/entities/home_entity.dart",
        "lib/features/home/domain/repositories/home_repository.dart",
        "lib/features/home/domain/usecases/get_home_message.dart",
        "lib/features/home/data/models/home_model.dart",
        "lib/features/home/data/repositories/home_repository_impl.dart",
        "lib/features/home/presentation/bloc/home_bloc.dart",
        "lib/features/home/presentation/pages/home_page.dart",
        "lib/features/home/presentation/widgets/home_widget.dart"
    ]
    
    import_errors = []
    
    for file_path in dart_files:
        if os.path.exists(file_path):
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    
                # 检查import语句
                import_lines = re.findall(r'import\s+[\'"]([^\'"]+)[\'"]', content)
                
                # 检查相对路径import
                for import_path in import_lines:
                    if import_path.startswith('package:'):
                        continue
                    if import_path.startswith('dart:'):
                        continue
                    if import_path.startswith('flutter'):
                        continue
                    
                    # 检查相对路径是否正确
                    if not import_path.startswith('.'):
                        import_errors.append(f"{file_path}: {import_path}")
                        
            except Exception as e:
                import_errors.append(f"{file_path}: 读取错误 - {e}")
    
    if import_errors:
        print(f"❌ 发现import问题:")
        for error in import_errors:
            print(f"   - {error}")
        return False
    else:
        print("✅ 所有import语句都正确")
        return True

def check_pubspec_dependencies():
    """检查pubspec.yaml依赖配置"""
    print("\n🔍 检查pubspec.yaml依赖配置...")
    
    try:
        with open("pubspec.yaml", 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 检查必需的依赖
        required_deps = [
            "flutter_bloc",
            "get_it", 
            "go_router",
            "equatable",
            "dartz"
        ]
        
        missing_deps = []
        for dep in required_deps:
            if dep not in content:
                missing_deps.append(dep)
        
        if missing_deps:
            print(f"❌ 缺少以下依赖:")
            for dep in missing_deps:
                print(f"   - {dep}")
            return False
        else:
            print("✅ 所有必需依赖都已配置")
            return True
            
    except Exception as e:
        print(f"❌ 读取pubspec.yaml失败: {e}")
        return False

def check_code_quality():
    """检查代码质量"""
    print("\n🔍 检查代码质量...")
    
    dart_files = [
        "lib/main.dart",
        "lib/core/constants/app_constants.dart",
        "lib/core/theme/app_theme.dart",
        "lib/core/utils/error_handler.dart",
        "lib/core/widgets/common_widgets.dart",
        "lib/core/di/dependency_injection.dart",
        "lib/features/home/domain/entities/home_entity.dart",
        "lib/features/home/domain/repositories/home_repository.dart",
        "lib/features/home/domain/usecases/get_home_message.dart",
        "lib/features/home/data/models/home_model.dart",
        "lib/features/home/data/repositories/home_repository_impl.dart",
        "lib/features/home/presentation/bloc/home_bloc.dart",
        "lib/features/home/presentation/pages/home_page.dart",
        "lib/features/home/presentation/widgets/home_widget.dart"
    ]
    
    total_lines = 0
    total_files = 0
    
    for file_path in dart_files:
        if os.path.exists(file_path):
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    lines = len(content.split('\n'))
                    total_lines += lines
                    total_files += 1
                    
            except Exception as e:
                print(f"❌ 读取 {file_path} 失败: {e}")
    
    print(f"✅ 代码统计:")
    print(f"   - 总文件数: {total_files}")
    print(f"   - 总代码行数: {total_lines}")
    print(f"   - 平均每文件行数: {total_lines // total_files if total_files > 0 else 0}")
    
    return True

def main():
    """主函数"""
    print("🚀 Foundation Agents 项目验证开始...\n")
    
    checks = [
        check_file_structure(),
        check_dart_imports(),
        check_pubspec_dependencies(),
        check_code_quality()
    ]
    
    print("\n" + "="*50)
    print("📊 验证结果汇总:")
    
    passed = sum(checks)
    total = len(checks)
    
    if passed == total:
        print("🎉 所有检查都通过！项目结构完整，代码质量良好。")
        print("\n📝 下一步操作:")
        print("1. 安装Flutter SDK")
        print("2. 运行 'flutter pub get' 获取依赖")
        print("3. 运行 'flutter run' 启动应用")
        print("4. 运行 'flutter test' 执行测试")
    else:
        print(f"⚠️  {passed}/{total} 项检查通过，需要修复一些问题。")
    
    print("\n💡 提示: 如果Flutter未安装，请访问 https://flutter.dev/docs/get-started/install")

if __name__ == "__main__":
    main()
