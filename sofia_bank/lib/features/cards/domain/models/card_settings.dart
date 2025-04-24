import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/cards/domain/enums/card_status.dart';

class CardSettings extends Equatable {
  final String cardId;
  final CardStatus status;
  final double onlineLimit;
  final double posLimit;
  final double transferLimit;
  final bool contactlessEnabled;
  final bool onlineTransactionsEnabled;

  const CardSettings({
    required this.cardId,
    required this.status,
    required this.onlineLimit,
    required this.posLimit,
    required this.transferLimit,
    required this.contactlessEnabled,
    required this.onlineTransactionsEnabled,
  });

  CardSettings copyWith({
    String? cardId,
    CardStatus? status,
    double? onlineLimit,
    double? posLimit,
    double? transferLimit,
    bool? contactlessEnabled,
    bool? onlineTransactionsEnabled,
  }) {
    return CardSettings(
      cardId: cardId ?? this.cardId,
      status: status ?? this.status,
      onlineLimit: onlineLimit ?? this.onlineLimit,
      posLimit: posLimit ?? this.posLimit,
      transferLimit: transferLimit ?? this.transferLimit,
      contactlessEnabled: contactlessEnabled ?? this.contactlessEnabled,
      onlineTransactionsEnabled:
          onlineTransactionsEnabled ?? this.onlineTransactionsEnabled,
    );
  }

  @override
  List<Object?> get props => [
        cardId,
        status,
        onlineLimit,
        posLimit,
        transferLimit,
        contactlessEnabled,
        onlineTransactionsEnabled,
      ];
}
