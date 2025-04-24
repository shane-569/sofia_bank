import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';
import 'package:sofia_bank/features/cards/presentation/pages/transaction_details_page.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionEntity transaction;
  final String cardNumber;

  const TransactionListItem({
    Key? key,
    required this.transaction,
    required this.cardNumber,
  }) : super(key: key);

  Color _getAmountColor() {
    switch (transaction.type.toLowerCase()) {
      case 'income':
        return Colors.green;
      case 'failed':
        return Colors.red;
      default:
        return Colors.black87;
    }
  }

  String _getTransactionLabel() {
    switch (transaction.type.toLowerCase()) {
      case 'income':
        return 'Receive';
      case 'transfer':
        return 'Transfer';
      case 'failed':
        return 'Failed';
      default:
        return transaction.type;
    }
  }

  String _getAmountPrefix() {
    switch (transaction.type.toLowerCase()) {
      case 'income':
        return '+';
      case 'transfer':
        return '-';
      case 'failed':
        return '';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsPage(
              transaction: transaction,
              cardNumber: cardNumber,
            ),
          ),
        );
      },
      child: Padding(
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
                        _getTransactionLabel(),
                        style: TextStyle(
                          fontSize: AppSizes.textSM,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        ' • ',
                        style: TextStyle(
                          fontSize: AppSizes.textSM,
                          color: Colors.grey[600],
                        ),
                      ),
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
              '${_getAmountPrefix()}\$${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: AppSizes.textLG,
                fontWeight: FontWeight.w600,
                color: _getAmountColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
