import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

enum LoanStatus {
  ongoing,
  closed,
  rejected,
}

extension LoanStatusExtension on LoanStatus {
  String get label {
    switch (this) {
      case LoanStatus.ongoing:
        return 'Ongoing';
      case LoanStatus.closed:
        return 'Closed';
      case LoanStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case LoanStatus.ongoing:
        return AppColors.primary;
      case LoanStatus.closed:
        return AppColors.success;
      case LoanStatus.rejected:
        return AppColors.error;
    }
  }
}

class Loan {
  final String id;
  final String type;
  final double amount;
  final double interestRate;
  final int tenure; // in months
  final DateTime startDate;
  final DateTime? endDate;
  final LoanStatus status;
  final double emi;
  final double amountPaid;

  const Loan({
    required this.id,
    required this.type,
    required this.amount,
    required this.interestRate,
    required this.tenure,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.emi,
    required this.amountPaid,
  });
}
