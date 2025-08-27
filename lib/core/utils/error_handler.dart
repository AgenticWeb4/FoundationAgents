import 'package:dartz/dartz.dart';

/// 应用程序错误类型
abstract class AppError {
  final String message;
  final String? code;
  
  const AppError(this.message, {this.code});
  
  @override
  String toString() => 'AppError: $message';
}

/// 网络错误
class NetworkError extends AppError {
  const NetworkError(String message, {String? code}) : super(message, code: code);
}

/// 服务器错误
class ServerError extends AppError {
  const ServerError(String message, {String? code}) : super(message, code: code);
}

/// 验证错误
class ValidationError extends AppError {
  const ValidationError(String message, {String? code}) : super(message, code: code);
}

/// 未知错误
class UnknownError extends AppError {
  const UnknownError(String message, {String? code}) : super(message, code: code);
}

/// 错误处理工具类
class ErrorHandler {
  /// 处理异常并返回Either类型
  static Either<AppError, T> handleException<T>(
    dynamic exception,
    StackTrace? stackTrace,
  ) {
    if (exception is AppError) {
      return Left(exception);
    }
    
    if (exception is FormatException) {
      return Left(ValidationError(exception.message));
    }
    
    if (exception.toString().contains('SocketException') ||
        exception.toString().contains('NetworkException')) {
      return Left(const NetworkError('网络连接错误'));
    }
    
    if (exception.toString().contains('HttpException')) {
      return Left(const ServerError('服务器错误'));
    }
    
    return Left(UnknownError(exception.toString()));
  }
  
  /// 从Either中提取值或抛出错误
  static T extractValue<T>(Either<AppError, T> either) {
    return either.fold(
      (error) => throw error,
      (value) => value,
    );
  }
  
  /// 检查是否成功
  static bool isSuccess<T>(Either<AppError, T> either) {
    return either.isRight();
  }
  
  /// 获取错误信息
  static String? getErrorMessage<T>(Either<AppError, T> either) {
    return either.fold(
      (error) => error.message,
      (value) => null,
    );
  }
}
