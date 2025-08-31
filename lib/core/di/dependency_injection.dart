import 'package:get_it/get_it.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_message.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

/// 全局依赖注入实例
final GetIt getIt = GetIt.instance;

/// 配置依赖注入
Future<void> configureDependencies() async {
  // 注册Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(),
  );
  
  // 注册UseCase
  getIt.registerLazySingleton(
    () => GetHomeMessage(getIt<HomeRepository>()),
  );
  
  // 注册BLoC
  getIt.registerFactory(
    () => HomeBloc(getIt<GetHomeMessage>()),
  );
}

/// 清理依赖注入
Future<void> resetDependencies() async {
  await getIt.reset();
}
