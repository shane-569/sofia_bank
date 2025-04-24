import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';

enum LoanFormStatus { initial, loading, success, failure }

class LoanFormState extends Equatable {
  final LoanType loanType;
  final double amount;
  final int tenure;
  final double interestRate;
  final String fullName;
  final String email;
  final String phone;
  final double monthlyIncome;
  final bool isEmployed;
  final String occupation;
  final String companyName;
  final double emi;
  final LoanFormStatus status;
  final String? errorMessage;
  final bool isFormValid;

  const LoanFormState({
    required this.loanType,
    this.amount = 0,
    this.tenure = 0,
    this.interestRate = 0,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.monthlyIncome = 0,
    this.isEmployed = true,
    this.occupation = '',
    this.companyName = '',
    this.emi = 0,
    this.status = LoanFormStatus.initial,
    this.errorMessage,
    this.isFormValid = false,
  });

  LoanFormState copyWith({
    LoanType? loanType,
    double? amount,
    int? tenure,
    double? interestRate,
    String? fullName,
    String? email,
    String? phone,
    double? monthlyIncome,
    bool? isEmployed,
    String? occupation,
    String? companyName,
    double? emi,
    LoanFormStatus? status,
    String? errorMessage,
    bool? isFormValid,
  }) {
    return LoanFormState(
      loanType: loanType ?? this.loanType,
      amount: amount ?? this.amount,
      tenure: tenure ?? this.tenure,
      interestRate: interestRate ?? this.interestRate,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      isEmployed: isEmployed ?? this.isEmployed,
      occupation: occupation ?? this.occupation,
      companyName: companyName ?? this.companyName,
      emi: emi ?? this.emi,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
        loanType,
        amount,
        tenure,
        interestRate,
        fullName,
        email,
        phone,
        monthlyIncome,
        isEmployed,
        occupation,
        companyName,
        emi,
        status,
        errorMessage,
        isFormValid,
      ];
}
