import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';

class LoanInfo extends Equatable {
  final LoanType type;
  final double minAmount;
  final double maxAmount;
  final double interestRate;
  final int minTenure;
  final int maxTenure;
  final List<String> requiredDocuments;
  final List<String> eligibilityCriteria;
  final String processingFee;

  const LoanInfo({
    required this.type,
    required this.minAmount,
    required this.maxAmount,
    required this.interestRate,
    required this.minTenure,
    required this.maxTenure,
    required this.requiredDocuments,
    required this.eligibilityCriteria,
    required this.processingFee,
  });

  @override
  List<Object?> get props => [
        type,
        minAmount,
        maxAmount,
        interestRate,
        minTenure,
        maxTenure,
        requiredDocuments,
        eligibilityCriteria,
        processingFee,
      ];
}
