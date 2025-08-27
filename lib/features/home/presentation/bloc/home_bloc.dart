import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/get_home_message.dart';
import '../../../core/utils/error_handler.dart';

// Events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {
  final String? customMessage;
  
  const LoadHomeData({this.customMessage});
  
  @override
  List<Object?> get props => [customMessage];
}

class RefreshHomeData extends HomeEvent {
  const RefreshHomeData();
}

class UpdateHomeMessage extends HomeEvent {
  final String message;
  
  const UpdateHomeMessage(this.message);
  
  @override
  List<Object> get props => [message];
}

// States
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeEntity homeEntity;
  
  const HomeLoaded(this.homeEntity);
  
  @override
  List<Object> get props => [homeEntity];
}

class HomeError extends HomeState {
  final String message;
  
  const HomeError(this.message);
  
  @override
  List<Object> get props => [message];
}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeMessage _getHomeMessage;
  
  HomeBloc(this._getHomeMessage) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<UpdateHomeMessage>(_onUpdateHomeMessage);
  }
  
  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    
    try {
      final params = GetHomeMessageParams(
        customMessage: event.customMessage,
      );
      
      final result = await _getHomeMessage(params);
      
      result.fold(
        (error) => emit(HomeError(error.message)),
        (homeEntity) => emit(HomeLoaded(homeEntity)),
      );
    } catch (e, stackTrace) {
      final error = ErrorHandler.handleException(e, stackTrace);
      emit(HomeError(error.fold(
        (appError) => appError.message,
        (value) => '未知错误',
      )));
    }
  }
  
  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    
    try {
      final params = const GetHomeMessageParams();
      final result = await _getHomeMessage(params);
      
      result.fold(
        (error) => emit(HomeError(error.message)),
        (homeEntity) => emit(HomeLoaded(homeEntity)),
      );
    } catch (e, stackTrace) {
      final error = ErrorHandler.handleException(e, stackTrace);
      emit(HomeError(error.fold(
        (appError) => appError.message,
        (value) => '未知错误',
      )));
    }
  }
  
  Future<void> _onUpdateHomeMessage(
    UpdateHomeMessage event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedEntity = currentState.homeEntity.copyWith(
        message: event.message,
        createdAt: DateTime.now(),
      );
      
      emit(HomeLoaded(updatedEntity));
    }
  }
}
