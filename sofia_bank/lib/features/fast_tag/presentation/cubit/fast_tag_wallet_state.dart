import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_option.dart';

class FastTagWalletState extends Equatable {
  final double amount;
  final PaymentOption? selectedPaymentOption;
  final String? upiId;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;
  final String? netBankingDetails;

  FastTagWalletState({
    this.amount = 0.0,
    this.selectedPaymentOption,
    this.upiId,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.netBankingDetails,
  });

  @override
  List<Object?> get props => [
        amount,
        selectedPaymentOption,
        upiId,
        cardNumber,
        expiryDate,
        cvv,
        netBankingDetails,
      ];

  FastTagWalletState copyWith({
    double? amount,
    PaymentOption? selectedPaymentOption,
    String? upiId,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? netBankingDetails,
  }) {
    return FastTagWalletState(
      amount: amount ?? this.amount,
      selectedPaymentOption:
          selectedPaymentOption ?? this.selectedPaymentOption,
      upiId: upiId ?? this.upiId,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      netBankingDetails: netBankingDetails ?? this.netBankingDetails,
    );
  }
}
