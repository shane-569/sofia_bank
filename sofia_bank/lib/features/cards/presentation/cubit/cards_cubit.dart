import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/cards/domain/entities/card_entity.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(CardsInitial());

  void loadCards() async {
    emit(CardsLoading());

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    final cards = [
      const CardEntity(
        id: '1',
        cardNumber: '4532 **** **** 7890',
        cardHolderName: 'JOHN DOE',
        expiryDate: '12/25',
        cvv: '123',
        type: 'visa',
        balance: 5420.50,
        currency: '\$',
        cardColor: AppColors.primary,
      ),
      const CardEntity(
        id: '2',
        cardNumber: '5412 **** **** 1234',
        cardHolderName: 'JOHN DOE',
        expiryDate: '09/24',
        cvv: '456',
        type: 'mastercard',
        balance: 3250.75,
        currency: '\$',
        cardColor: AppColors.secondary,
      ),
      const CardEntity(
        id: '3',
        cardNumber: '3782 **** **** 5678',
        cardHolderName: 'JOHN DOE',
        expiryDate: '03/26',
        cvv: '789',
        type: 'amex',
        balance: 7890.25,
        currency: '\$',
        cardColor: const Color(0xFF1B1464),
      ),
    ];

    final transactions = [
      TransactionEntity(
        id: '1',
        name: 'Ruth Henry',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        amount: 1200,
        date: DateTime(2024, 9, 12),
        type: 'income',
        cardId: '1',
      ),
      TransactionEntity(
        id: '2',
        name: 'Lily Alexa',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        amount: 2600,
        date: DateTime(2024, 9, 11),
        type: 'income',
        cardId: '1',
      ),
      TransactionEntity(
        id: '3',
        name: 'Anne Brown',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        amount: 1100,
        date: DateTime(2024, 9, 10),
        type: 'income',
        cardId: '1',
      ),
      TransactionEntity(
        id: '4',
        name: 'John Smith',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        amount: 800,
        date: DateTime(2024, 9, 9),
        type: 'transfer',
        cardId: '2',
      ),
      TransactionEntity(
        id: '5',
        name: 'Emma Wilson',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        amount: 1500,
        date: DateTime(2024, 9, 8),
        type: 'transfer',
        cardId: '2',
      ),
      TransactionEntity(
        id: '6',
        name: 'Michael Davis',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
        amount: 2000,
        date: DateTime(2024, 9, 7),
        type: 'transfer',
        cardId: '1',
      ),
      TransactionEntity(
        id: '7',
        name: 'Sarah Johnson',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        amount: 3500,
        date: DateTime(2024, 9, 6),
        type: 'failed',
        cardId: '1',
      ),
      TransactionEntity(
        id: '8',
        name: 'David Miller',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        amount: 1800,
        date: DateTime(2024, 9, 5),
        type: 'failed',
        cardId: '2',
      ),
      TransactionEntity(
        id: '9',
        name: 'Jessica Lee',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        amount: 2200,
        date: DateTime(2024, 9, 4),
        type: 'failed',
        cardId: '3',
      ),
    ];

    emit(CardsLoaded(
      cards: cards,
      selectedCardIndex: 0,
      transactions: transactions,
    ));
  }

  void selectCard(int index) {
    final currentState = state;
    if (currentState is CardsLoaded) {
      emit(CardsLoaded(
        cards: currentState.cards,
        selectedCardIndex: index,
        transactions: currentState.transactions,
      ));
    }
  }
}
