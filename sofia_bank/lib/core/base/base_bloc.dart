import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  @override
  Future<void> close() {
    // Add any cleanup logic here
    return super.close();
  }
}
