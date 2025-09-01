import 'package:equatable/equatable.dart';

/// Home页面的核心实体
class HomeEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isActive;
  
  const HomeEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isActive,
  });
  
  /// 创建默认的Home实体
  factory HomeEntity.defaultHome() {
    return HomeEntity(
      id: 'default',
      title: '欢迎使用',
      message: 'Hello World! 这是一个基于Clean Architecture和BLoC模式的Flutter应用。',
      createdAt: DateTime.now(),
      isActive: true,
    );
  }
  
  /// 复制并修改实体
  HomeEntity copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return HomeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
  
  @override
  List<Object?> get props => [id, title, message, createdAt, isActive];
  
  @override
  String toString() {
    return 'HomeEntity(id: $id, title: $title, message: $message, createdAt: $createdAt, isActive: $isActive)';
  }
}
