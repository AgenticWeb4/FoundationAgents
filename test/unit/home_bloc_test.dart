import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foundation_agents/features/home/domain/entities/home_entity.dart';
import 'package:foundation_agents/features/home/domain/usecases/get_home_message.dart';
import 'package:foundation_agents/features/home/presentation/bloc/home_bloc.dart';
import 'package:foundation_agents/core/utils/error_handler.dart';

// 生成Mock类
@GenerateMocks([GetHomeMessage])
import 'home_bloc_test.mocks.dart';

void main() {
  group('HomeBloc', () {
    late MockGetHomeMessage mockGetHomeMessage;
    late HomeBloc homeBloc;

    setUp(() {
      mockGetHomeMessage = MockGetHomeMessage();
      homeBloc = HomeBloc(mockGetHomeMessage);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('初始状态应该是HomeInitial', () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    blocTest<HomeBloc, HomeState>(
      '当LoadHomeData成功时应该发出HomeLoaded状态',
      build: () {
        when(mockGetHomeMessage(any)).thenAnswer(
          (_) async => Right(HomeEntity.defaultHome()),
        );
        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
      verify: (_) {
        verify(mockGetHomeMessage(any)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      '当LoadHomeData失败时应该发出HomeError状态',
      build: () {
        when(mockGetHomeMessage(any)).thenAnswer(
          (_) async => const Left(UnknownError('测试错误')),
        );
        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
      verify: (_) {
        verify(mockGetHomeMessage(any)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      '当RefreshHomeData成功时应该发出HomeLoaded状态',
      build: () {
        when(mockGetHomeMessage(any)).thenAnswer(
          (_) async => Right(HomeEntity.defaultHome()),
        );
        return homeBloc;
      },
      act: (bloc) => bloc.add(const RefreshHomeData()),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
      verify: (_) {
        verify(mockGetHomeMessage(any)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      '当UpdateHomeMessage时应该更新消息',
      build: () {
        when(mockGetHomeMessage(any)).thenAnswer(
          (_) async => Right(HomeEntity.defaultHome()),
        );
        return homeBloc;
      },
      act: (bloc) {
        bloc.add(const LoadHomeData());
        bloc.add(const UpdateHomeMessage('新消息'));
      },
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
        isA<HomeLoaded>(),
      ],
      verify: (_) {
        verify(mockGetHomeMessage(any)).called(1);
      },
    );
  });
}
