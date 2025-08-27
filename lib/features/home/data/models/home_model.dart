import 'package:equatable/equatable.dart';
import '../../domain/entities/home_entity.dart';

/// Home数据模型
class HomeModel extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime? createdAt;
  final bool isActive;
  
  const HomeModel({
    required this.id,
    required this.title,
    required this.message,
    this.createdAt,
    required this.isActive,
  });
  
  /// 从JSON创建模型
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
      'isActive': isActive,
    };
  }
  
  /// 从实体创建模型
  factory HomeModel.fromEntity(HomeEntity entity) {
    return HomeModel(
      id: entity.id,
      title: entity.title,
      message: entity.message,
      createdAt: entity.createdAt,
      isActive: entity.isActive,
    );
  }
  
  /// 转换为实体
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      title: title,
      message: message,
      createdAt: createdAt,
      isActive: isActive,
    );
  }
  
  /// 复制并修改模型
  HomeModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return HomeModel(
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
    return 'HomeModel(id: $id, title: $title, message: $message, createdAt: $createdAt, isActive: $isActive)';
  }
}
