import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/network/network_service.dart';
import 'package:sofia_bank/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NetworkService _networkService;

  HomeCubit(this._networkService) : super(HomeState.initial());

  Future<void> fetchBalance() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // Make API call to fetch balance
      final response = await _networkService.get('/account/balance');

      emit(state.copyWith(
        isLoading: false,
        balance: response['balance'] ?? 0.0,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
