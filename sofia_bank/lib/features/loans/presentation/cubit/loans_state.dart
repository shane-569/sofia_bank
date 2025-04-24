import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';
import 'package:sofia_bank/features/loans/domain/models/loan_info.dart';

enum LoansStatus { initial, loading, success, failure }

class LoansState extends Equatable {
  final Map<LoanType, LoanInfo> loanInfo;
  final LoanType selectedType;
  final LoansStatus status;
  final String? errorMessage;

  const LoansState({
    this.loanInfo = const {},
    this.selectedType = LoanType.personal,
    this.status = LoansStatus.initial,
    this.errorMessage,
  });

  LoansState copyWith({
    Map<LoanType, LoanInfo>? loanInfo,
    LoanType? selectedType,
    LoansStatus? status,
    String? errorMessage,
  }) {
    return LoansState(
      loanInfo: loanInfo ?? this.loanInfo,
      selectedType: selectedType ?? this.selectedType,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loanInfo, selectedType, status, errorMessage];
}
