import 'package:dartz/dartz.dart';
import '../entities/home_entity.dart';
import '../../../../core/utils/error_handler.dart';

/// Home功能的数据仓库接口
abstract class HomeRepository {
  /// 获取Home数据
  Future<Either<AppError, HomeEntity>> getHomeData();
  
  /// 更新Home数据
  Future<Either<AppError, HomeEntity>> updateHomeData(HomeEntity homeEntity);
  
  /// 创建新的Home数据
  Future<Either<AppError, HomeEntity>> createHomeData(HomeEntity homeEntity);
  
  /// 删除Home数据
  Future<Either<AppError, bool>> deleteHomeData(String id);
  
  /// 获取所有Home数据列表
  Future<Either<AppError, List<HomeEntity>>> getAllHomeData();
}
