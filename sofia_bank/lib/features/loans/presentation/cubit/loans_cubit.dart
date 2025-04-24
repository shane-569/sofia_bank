import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';
import 'package:sofia_bank/features/loans/domain/models/loan_info.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loans_state.dart';

class LoansCubit extends Cubit<LoansState> {
  LoansCubit() : super(const LoansState());

  void updateSelectedType(LoanType type) {
    emit(state.copyWith(selectedType: type));
  }

  Future<void> loadLoans() async {
    emit(state.copyWith(status: LoansStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final loanInfo = {
        LoanType.personal: const LoanInfo(
          type: LoanType.personal,
          minAmount: 1000,
          maxAmount: 50000,
          interestRate: 8.5,
          minTenure: 12,
          maxTenure: 60,
          processingFee: '2%',
          requiredDocuments: [
            'Valid ID Proof',
            'Income Proof',
            'Bank Statements (3 months)',
          ],
          eligibilityCriteria: [
            'Age: 21-65 years',
            'Minimum income: \$2,000/month',
            'Good credit score',
          ],
        ),
        LoanType.business: const LoanInfo(
          type: LoanType.business,
          minAmount: 25000,
          maxAmount: 500000,
          interestRate: 7.5,
          minTenure: 12,
          maxTenure: 84,
          processingFee: '1.5%',
          requiredDocuments: [
            'Business Registration',
            'Financial Statements',
            'Tax Returns (2 years)',
            'Business Plan',
            'Bank Statements (6 months)',
          ],
          eligibilityCriteria: [
            'Business age: 2+ years',
            'Minimum annual revenue: \$100,000',
            'Good business credit score',
            'Profitable for last 2 years',
          ],
        ),
        LoanType.gold: const LoanInfo(
          type: LoanType.gold,
          minAmount: 1000,
          maxAmount: 100000,
          interestRate: 5.5,
          minTenure: 3,
          maxTenure: 36,
          processingFee: '1%',
          requiredDocuments: [
            'Valid ID Proof',
            'Gold Ownership Proof',
            'Gold Purity Certificate',
            'Address Proof',
          ],
          eligibilityCriteria: [
            'Age: 21-70 years',
            'Minimum 18 carat gold',
            'Clean gold ownership',
            'Valid gold valuation',
          ],
        ),
        LoanType.education: const LoanInfo(
          type: LoanType.education,
          minAmount: 10000,
          maxAmount: 200000,
          interestRate: 6.5,
          minTenure: 12,
          maxTenure: 120,
          processingFee: '0.5%',
          requiredDocuments: [
            'College Admission Letter',
            'Academic Records',
            'Co-applicant Documents',
            'Course Fee Structure',
          ],
          eligibilityCriteria: [
            'Age: 18-35 years',
            'Admission in recognized institute',
            'Academic score: 60%+',
            'Co-applicant required',
          ],
        ),
        LoanType.home: const LoanInfo(
          type: LoanType.home,
          minAmount: 50000,
          maxAmount: 1000000,
          interestRate: 3.5,
          minTenure: 60,
          maxTenure: 360,
          processingFee: '1%',
          requiredDocuments: [
            'Property Documents',
            'Income Proof',
            'Bank Statements (6 months)',
            'Tax Returns (2 years)',
          ],
          eligibilityCriteria: [
            'Age: 25-65 years',
            'Minimum income: \$5,000/month',
            'Property valuation report',
            'Good credit score',
          ],
        ),
        LoanType.car: const LoanInfo(
          type: LoanType.car,
          minAmount: 5000,
          maxAmount: 100000,
          interestRate: 4.5,
          minTenure: 12,
          maxTenure: 84,
          processingFee: '1.5%',
          requiredDocuments: [
            'Vehicle Details',
            'Income Proof',
            'Bank Statements (3 months)',
            'Driving License',
          ],
          eligibilityCriteria: [
            'Age: 21-65 years',
            'Minimum income: \$3,000/month',
            'Good credit score',
          ],
        ),
      };

      emit(state.copyWith(
        status: LoansStatus.success,
        loanInfo: loanInfo,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoansStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
