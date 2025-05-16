import 'package:equatable/equatable.dart';
import '../../domain/entities/user_deposit_entity.dart';

enum UserDepositsStatus { initial, loading, success, error }

class UserDepositsState extends Equatable {
  final UserDepositsStatus status;
  final List<UserDepositEntity> deposits;
  final int selectedIndex;
  final String? errorMessage;

  const UserDepositsState({
    this.status = UserDepositsStatus.initial,
    this.deposits = const [],
    this.selectedIndex = 0,
    this.errorMessage,
  });

  UserDepositsState copyWith({
    UserDepositsStatus? status,
    List<UserDepositEntity>? deposits,
    int? selectedIndex,
    String? errorMessage,
  }) {
    return UserDepositsState(
      status: status ?? this.status,
      deposits: deposits ?? this.deposits,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, deposits, selectedIndex, errorMessage];
}
