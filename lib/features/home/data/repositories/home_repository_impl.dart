import 'package:dartz/dartz.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/home_model.dart';
import '../../../../core/utils/error_handler.dart';

/// Home仓库的实现
class HomeRepositoryImpl implements HomeRepository {
  // 模拟数据源，实际项目中可能是API或数据库
  static final Map<String, HomeModel> _mockData = {
    'default': HomeModel(
      id: 'default',
      title: '欢迎使用',
      message: 'Hello World! 这是一个基于Clean Architecture和BLoC模式的Flutter应用。',
      createdAt: DateTime.now(),
      isActive: true,
    ),
  };
  
  @override
  Future<Either<AppError, HomeEntity>> getHomeData() async {
    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 500));
      
      final homeModel = _mockData['default'];
      if (homeModel == null) {
        return Left(UnknownError('未找到Home数据'));
      }
      
      return Right(homeModel.toEntity());
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
  
  @override
  Future<Either<AppError, HomeEntity>> updateHomeData(HomeEntity homeEntity) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final homeModel = HomeModel.fromEntity(homeEntity);
      _mockData[homeEntity.id] = homeModel;
      
      return Right(homeEntity);
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
  
  @override
  Future<Either<AppError, HomeEntity>> createHomeData(HomeEntity homeEntity) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      
      final homeModel = HomeModel.fromEntity(homeEntity);
      _mockData[homeEntity.id] = homeModel;
      
      return Right(homeEntity);
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
  
  @override
  Future<Either<AppError, bool>> deleteHomeData(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      
      if (_mockData.containsKey(id)) {
        _mockData.remove(id);
        return const Right(true);
      }
      
      return Left(UnknownError('未找到要删除的数据'));
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
  
  @override
  Future<Either<AppError, List<HomeEntity>>> getAllHomeData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      
      final entities = _mockData.values.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
}
