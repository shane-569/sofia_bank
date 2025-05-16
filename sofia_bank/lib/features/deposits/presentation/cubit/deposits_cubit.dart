import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/deposits/presentation/cubit/deposits_state.dart';
import '../../domain/entities/deposit_entity.dart';

class DepositsCubit extends Cubit<DepositsState> {
  DepositsCubit() : super(const DepositsState());

  Future<void> loadDeposits() async {
    emit(state.copyWith(status: DepositsStatus.loading));

    try {
      // Simulated delay to mimic API call
      await Future.delayed(const Duration(seconds: 1));

      final deposits = [
        const DepositEntity(
          id: '1',
          name: 'Fixed Deposit',
          interestRate: 7.5,
          minAmount: 10000,
          minTenure: 12,
          maxTenure: 60,
          features: [
            'Guaranteed returns',
            'Flexible tenure options',
            'Auto-renewal facility',
            'Loan against FD available'
          ],
          requirements: [
            'Valid ID proof',
            'Address proof',
            'Bank account details',
            'Recent photograph'
          ],
        ),
        const DepositEntity(
          id: '2',
          name: 'Recurring Deposit',
          interestRate: 6.75,
          minAmount: 1000,
          minTenure: 6,
          maxTenure: 120,
          features: [
            'Monthly investment option',
            'Systematic savings',
            'Higher interest rates',
            'Flexible deposit amount'
          ],
          requirements: [
            'Valid ID proof',
            'Address proof',
            'Bank account for auto-debit',
            'Recent photograph'
          ],
        ),
        const DepositEntity(
          id: '3',
          name: 'Tax Saver Deposit',
          interestRate: 6.9,
          minAmount: 5000,
          minTenure: 60,
          maxTenure: 120,
          features: [
            'Tax benefits under Section 80C',
            'Fixed 5-year lock-in period',
            'Competitive interest rates',
            'Option for monthly interest payout'
          ],
          requirements: [
            'PAN card',
            'Valid ID proof',
            'Address proof',
            'Recent photograph'
          ],
        ),
        const DepositEntity(
          id: '4',
          name: 'Senior Citizen Deposit',
          interestRate: 8.0,
          minAmount: 10000,
          minTenure: 12,
          maxTenure: 120,
          features: [
            'Additional 0.5% interest rate',
            'Monthly interest payout option',
            'Premature withdrawal allowed',
            'Special care and priority service'
          ],
          requirements: [
            'Age proof (60+ years)',
            'Valid ID proof',
            'Address proof',
            'Recent photograph'
          ],
        ),
      ];

      emit(state.copyWith(
        status: DepositsStatus.success,
        deposits: deposits,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DepositsStatus.error,
        errorMessage: 'Failed to load deposits: ${e.toString()}',
      ));
    }
  }
}
