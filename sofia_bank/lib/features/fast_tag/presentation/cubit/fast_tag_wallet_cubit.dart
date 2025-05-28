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

  void updateUpiId(String? upiId) {
    emit(state.copyWith(upiId: upiId));
  }

  void updateCardNumber(String? cardNumber) {
    emit(state.copyWith(cardNumber: cardNumber));
  }

  void updateExpiryDate(String? expiryDate) {
    emit(state.copyWith(expiryDate: expiryDate));
  }

  void updateCvv(String? cvv) {
    emit(state.copyWith(cvv: cvv));
  }

  void updateNetBankingDetails(String? netBankingDetails) {
    emit(state.copyWith(netBankingDetails: netBankingDetails));
  }

  void selectPaymentOption(PaymentOption option) {
    if (state.selectedPaymentOption == option) {
      // Deselect and clear all
      emit(state.copyWith(
        selectedPaymentOption: null,
        upiId: null,
        cardNumber: null,
        expiryDate: null,
        cvv: null,
        netBankingDetails: null,
      ));
    } else {
      // Select new option and clear others
      FastTagWalletState newState =
          state.copyWith(selectedPaymentOption: option);

      // Clear data for other options
      switch (option) {
        case PaymentOption.upi:
          newState = newState.copyWith(
              cardNumber: null,
              expiryDate: null,
              cvv: null,
              netBankingDetails: null);
          break;
        case PaymentOption.card:
          newState = newState.copyWith(upiId: null, netBankingDetails: null);
          break;
        case PaymentOption.netBanking:
          newState = newState.copyWith(
              upiId: null, cardNumber: null, expiryDate: null, cvv: null);
          break;
      }
      emit(newState);
    }
  }
}
