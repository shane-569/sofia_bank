import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_option.dart';

class FastTagWalletState extends Equatable {
  final double amount;
  final PaymentOption? selectedPaymentOption;

  FastTagWalletState({
    this.amount = 0.0,
    this.selectedPaymentOption,
  });

  @override
  List<Object?> get props => [amount, selectedPaymentOption];

  FastTagWalletState copyWith({
    double? amount,
    PaymentOption? selectedPaymentOption,
  }) {
    return FastTagWalletState(
      amount: amount ?? this.amount,
      selectedPaymentOption:
          selectedPaymentOption ?? this.selectedPaymentOption,
    );
  }
}
