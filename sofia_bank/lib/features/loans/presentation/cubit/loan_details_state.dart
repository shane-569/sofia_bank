import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';

enum LoanDetailsStatus { initial, loading, success, failure }

class LoanDetailsState extends Equatable {
  final LoanDetailsStatus status;
  final Loan? loan;
  final List<EmiDetail> emiDetails;
  final String? errorMessage;

  const LoanDetailsState({
    this.status = LoanDetailsStatus.initial,
    this.loan,
    this.emiDetails = const [],
    this.errorMessage,
  });

  LoanDetailsState copyWith({
    LoanDetailsStatus? status,
    Loan? loan,
    List<EmiDetail>? emiDetails,
    String? errorMessage,
  }) {
    return LoanDetailsState(
      status: status ?? this.status,
      loan: loan ?? this.loan,
      emiDetails: emiDetails ?? this.emiDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, loan, emiDetails, errorMessage];
}

class EmiDetail {
  final int emiNumber;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime? paidDate;

  const EmiDetail({
    required this.emiNumber,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
    this.paidDate,
  });
}
