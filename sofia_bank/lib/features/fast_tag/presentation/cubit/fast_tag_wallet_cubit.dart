import 'package:flutter_bloc/flutter_bloc.dart';
import 'fast_tag_wallet_state.dart';
import '../../domain/entities/payment_option.dart';

class FastTagWalletCubit extends Cubit<FastTagWalletState> {
  FastTagWalletCubit() : super(FastTagWalletState());

  void updateAmount(double newAmount) {
    emit(state.copyWith(amount: newAmount));
  }

  void addAmount(double value) {
    final updatedAmount = state.amount + value;
    print(
        'FastTagWalletCubit - Before emit. Current state amount: ${state.amount}');
    emit(state.copyWith(amount: updatedAmount));
    print('FastTagWalletCubit - Emitted state with amount: $updatedAmount');
  }

  void selectPaymentOption(PaymentOption option) {
    emit(state.copyWith(selectedPaymentOption: option));
  }
}
