import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T initialState) : super(initialState);

  @override
  Future<void> close() {
    // Add any cleanup logic here
    return super.close();
  }
}
