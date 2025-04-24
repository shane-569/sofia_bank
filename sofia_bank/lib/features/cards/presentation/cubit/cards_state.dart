import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/cards/domain/entities/card_entity.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';

abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object?> get props => [];
}

class CardsInitial extends CardsState {}

class CardsLoading extends CardsState {}

class CardsLoaded extends CardsState {
  final List<CardEntity> cards;
  final int selectedCardIndex;
  final List<TransactionEntity> transactions;

  const CardsLoaded({
    required this.cards,
    required this.selectedCardIndex,
    required this.transactions,
  });

  @override
  List<Object?> get props => [cards, selectedCardIndex, transactions];

  CardsLoaded copyWith({
    List<CardEntity>? cards,
    int? selectedCardIndex,
    List<TransactionEntity>? transactions,
  }) {
    return CardsLoaded(
      cards: cards ?? this.cards,
      selectedCardIndex: selectedCardIndex ?? this.selectedCardIndex,
      transactions: transactions ?? this.transactions,
    );
  }
}

class CardsError extends CardsState {
  final String message;

  const CardsError(this.message);

  @override
  List<Object?> get props => [message];
}
