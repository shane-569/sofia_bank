import 'package:equatable/equatable.dart';
import '../../domain/entities/deposit_entity.dart';

enum DepositsStatus { initial, loading, success, error }

class DepositsState extends Equatable {
  final DepositsStatus status;
  final List<DepositEntity> deposits;
  final String? errorMessage;

  const DepositsState({
    this.status = DepositsStatus.initial,
    this.deposits = const [],
    this.errorMessage,
  });

  DepositsState copyWith({
    DepositsStatus? status,
    List<DepositEntity>? deposits,
    String? errorMessage,
  }) {
    return DepositsState(
      status: status ?? this.status,
      deposits: deposits ?? this.deposits,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, deposits, errorMessage];
}
