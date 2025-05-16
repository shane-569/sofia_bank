import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_deposit_entity.dart';
import 'user_deposits_state.dart';

class UserDepositsCubit extends Cubit<UserDepositsState> {
  UserDepositsCubit() : super(const UserDepositsState());

  Future<void> loadUserDeposits() async {
    emit(state.copyWith(status: UserDepositsStatus.loading));

    try {
      // Simulated delay to mimic API call
      await Future.delayed(const Duration(seconds: 1));

      final deposits = [
        UserDepositEntity(
          id: '1',
          depositId: '1',
          depositName: 'Fixed Deposit',
          amount: 100000,
          interestRate: 7.5,
          tenure: 12,
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          maturityDate: DateTime.now().add(const Duration(days: 335)),
          maturityAmount: 107500,
          status: 'active',
        ),
        UserDepositEntity(
          id: '2',
          depositId: '2',
          depositName: 'Recurring Deposit',
          amount: 5000,
          interestRate: 6.75,
          tenure: 24,
          startDate: DateTime.now().subtract(const Duration(days: 60)),
          maturityDate: DateTime.now().add(const Duration(days: 670)),
          maturityAmount: 126000,
          status: 'active',
        ),
        UserDepositEntity(
          id: '3',
          depositId: '3',
          depositName: 'Tax Saver Deposit',
          amount: 150000,
          interestRate: 6.9,
          tenure: 60,
          startDate: DateTime.now().subtract(const Duration(days: 90)),
          maturityDate: DateTime.now().add(const Duration(days: 1735)),
          maturityAmount: 205000,
          status: 'active',
        ),
      ];

      emit(state.copyWith(
        status: UserDepositsStatus.success,
        deposits: deposits,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserDepositsStatus.error,
        errorMessage: 'Failed to load deposits: ${e.toString()}',
      ));
    }
  }

  void updateSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
