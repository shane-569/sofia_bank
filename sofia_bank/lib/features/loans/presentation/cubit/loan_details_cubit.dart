import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_details_state.dart';

class LoanDetailsCubit extends Cubit<LoanDetailsState> {
  LoanDetailsCubit() : super(const LoanDetailsState());

  Future<void> loadLoanDetails(Loan loan) async {
    emit(state.copyWith(status: LoanDetailsStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final emiDetails = _generateEmiDetails(loan);

      emit(state.copyWith(
        status: LoanDetailsStatus.success,
        loan: loan,
        emiDetails: emiDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoanDetailsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  List<EmiDetail> _generateEmiDetails(Loan loan) {
    final emiDetails = <EmiDetail>[];
    final emiAmount = loan.emi;
    final startDate = loan.startDate;
    final totalEmis = loan.tenure;
    final currentDate = DateTime.now();

    for (var i = 0; i < totalEmis; i++) {
      final dueDate = DateTime(
        startDate.year,
        startDate.month + i,
        startDate.day,
      );

      emiDetails.add(EmiDetail(
        emiNumber: i + 1,
        amount: emiAmount,
        dueDate: dueDate,
        isPaid: dueDate.isBefore(currentDate),
        paidDate: dueDate.isBefore(currentDate) ? dueDate : null,
      ));
    }

    return emiDetails;
  }
}
