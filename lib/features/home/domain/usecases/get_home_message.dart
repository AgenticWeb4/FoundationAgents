import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';
import '../../../../core/utils/error_handler.dart';

/// 获取Home消息的用例参数
class GetHomeMessageParams extends Equatable {
  final String? customMessage;
  
  const GetHomeMessageParams({this.customMessage});
  
  @override
  List<Object?> get props => [customMessage];
}

/// 获取Home消息的用例
class GetHomeMessage {
  final HomeRepository repository;
  
  const GetHomeMessage(this.repository);
  
  /// 执行用例
  Future<Either<AppError, HomeEntity>> call(GetHomeMessageParams params) async {
    try {
      final result = await repository.getHomeData();
      
      return result.fold(
        (error) => Left(error),
        (homeEntity) {
          // 如果有自定义消息，则更新实体
          if (params.customMessage != null) {
            final updatedEntity = homeEntity.copyWith(
              message: params.customMessage!,
              createdAt: DateTime.now(),
            );
            return Right(updatedEntity);
          }
          
          return Right(homeEntity);
        },
      );
    } catch (e, stackTrace) {
      return ErrorHandler.handleException(e, stackTrace);
    }
  }
}
