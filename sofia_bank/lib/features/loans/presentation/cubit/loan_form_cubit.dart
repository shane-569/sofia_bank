import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_form_state.dart';

class LoanFormCubit extends Cubit<LoanFormState> {
  LoanFormCubit({
    required LoanType initialLoanType,
    required double interestRate,
  }) : super(LoanFormState(
          loanType: initialLoanType,
          interestRate: interestRate,
        ));

  void updateAmount(double amount) {
    emit(state.copyWith(
      amount: amount,
      emi: _calculateEMI(amount, state.tenure, state.interestRate),
      isFormValid: _validateForm(),
    ));
  }

  void updateTenure(int tenure) {
    emit(state.copyWith(
      tenure: tenure,
      emi: _calculateEMI(state.amount, tenure, state.interestRate),
      isFormValid: _validateForm(),
    ));
  }

  void updateFullName(String fullName) {
    emit(state.copyWith(
      fullName: fullName,
      isFormValid: _validateForm(),
    ));
  }

  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
      isFormValid: _validateForm(),
    ));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(
      phone: phone,
      isFormValid: _validateForm(),
    ));
  }

  void updateMonthlyIncome(double monthlyIncome) {
    emit(state.copyWith(
      monthlyIncome: monthlyIncome,
      isFormValid: _validateForm(),
    ));
  }

  void updateEmploymentStatus(bool isEmployed) {
    emit(state.copyWith(
      isEmployed: isEmployed,
      isFormValid: _validateForm(),
    ));
  }

  void updateOccupation(String occupation) {
    emit(state.copyWith(
      occupation: occupation,
      isFormValid: _validateForm(),
    ));
  }

  void updateCompanyName(String companyName) {
    emit(state.copyWith(
      companyName: companyName,
      isFormValid: _validateForm(),
    ));
  }

  double _calculateEMI(double principal, int tenure, double interestRate) {
    if (principal <= 0 || tenure <= 0 || interestRate <= 0) return 0;

    // Convert interest rate to monthly rate
    double monthlyRate = (interestRate / 12) / 100;

    // Calculate EMI using formula: P * r * (1 + r)^n / ((1 + r)^n - 1)
    double emi = principal *
        monthlyRate *
        (pow((1 + monthlyRate), tenure)) /
        (pow((1 + monthlyRate), tenure) - 1);

    return double.parse(emi.toStringAsFixed(2));
  }

  bool _validateForm() {
    if (state.amount <= 0 ||
        state.tenure <= 0 ||
        state.fullName.isEmpty ||
        !_isValidEmail(state.email) ||
        !_isValidPhone(state.phone) ||
        state.monthlyIncome <= 0 ||
        (state.isEmployed &&
            (state.occupation.isEmpty || state.companyName.isEmpty))) {
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d-]{10,}$').hasMatch(phone);
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: LoanFormStatus.loading));

    try {
      // TODO: Implement API call to submit loan application
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      emit(state.copyWith(status: LoanFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LoanFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
