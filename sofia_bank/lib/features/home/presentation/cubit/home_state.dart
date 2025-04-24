import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(0.0) double balance,
    String? error,
  }) = _HomeState;

  const HomeState._();

  factory HomeState.initial() => const HomeState();
}
