class TransactionEntity {
  final String id;
  final String name;
  final String avatarUrl;
  final double amount;
  final DateTime date;
  final String type; // 'income' or 'transfer'
  final String cardId; // to link transaction with card

  const TransactionEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.amount,
    required this.date,
    required this.type,
    required this.cardId,
  });
}
