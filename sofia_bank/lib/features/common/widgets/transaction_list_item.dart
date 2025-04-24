import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing2XL,
        vertical: AppSizes.spacingMD,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(transaction.avatarUrl),
          ),
          const SizedBox(width: AppSizes.spacingLG),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: const TextStyle(
                    fontSize: AppSizes.textLG,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Receive',
                      style: TextStyle(
                        fontSize: AppSizes.textSM,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•',
                      style: TextStyle(
                        fontSize: AppSizes.textSM,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd MMM yyyy').format(transaction.date),
                      style: TextStyle(
                        fontSize: AppSizes.textSM,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '+\$${transaction.amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: AppSizes.textLG,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
