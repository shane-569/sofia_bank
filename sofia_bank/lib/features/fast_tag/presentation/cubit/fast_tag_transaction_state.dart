import 'package:equatable/equatable.dart';

// Data class for individual toll transactions
class TollTransaction extends Equatable {
  final String name;
  final double amount;
  final String date;

  const TollTransaction({
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [name, amount, date];
}

enum FastTagTransactionStatus {
  initial,
  loading,
  loaded,
  error,
}

class FastTagTransactionState extends Equatable {
  final FastTagTransactionStatus status;
  final double fastTagBalance;
  final String lastTollLocation;
  final List<TollTransaction> transactions;
  final String? errorMessage;

  const FastTagTransactionState({
    this.status = FastTagTransactionStatus.initial,
    this.fastTagBalance = 0.0,
    this.lastTollLocation = '',
    this.transactions = const [],
    this.errorMessage,
  });

  FastTagTransactionState copyWith({
    FastTagTransactionStatus? status,
    double? fastTagBalance,
    String? lastTollLocation,
    List<TollTransaction>? transactions,
    String? errorMessage,
  }) {
    return FastTagTransactionState(
      status: status ?? this.status,
      fastTagBalance: fastTagBalance ?? this.fastTagBalance,
      lastTollLocation: lastTollLocation ?? this.lastTollLocation,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        fastTagBalance,
        lastTollLocation,
        transactions,
        errorMessage,
      ];
}
