// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/transaction_list_item.dart';

class TransactionsSection extends StatefulWidget {
  final List<TransactionEntity> transactions;
  final String cardNumber;

  const TransactionsSection({
    Key? key,
    required this.transactions,
    required this.cardNumber,
  }) : super(key: key);

  @override
  State<TransactionsSection> createState() => _TransactionsSectionState();
}

class _TransactionsSectionState extends State<TransactionsSection> {
  String _selectedType = 'Income';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.spacing2XL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Last Transaction',
                  style: TextStyle(
                    fontSize: AppSizes.textXL,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See more',
                    style: TextStyle(
                      fontSize: AppSizes.textMD,
                      color: AppColors.primary.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.spacingXL),
              children: [
                _buildFilterChip('Income'),
                const SizedBox(width: AppSizes.spacingMD),
                _buildFilterChip('Transfer'),
                const SizedBox(width: AppSizes.spacingMD),
                _buildFilterChip('Failed'),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          ...widget.transactions
              .where((t) => t.type.toLowerCase() == _selectedType.toLowerCase())
              .take(3)
              .map((transaction) => TransactionListItem(
                    transaction: transaction,
                    cardNumber: widget.cardNumber,
                  )),
          const SizedBox(height: AppSizes.spacingLG),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedType == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = label),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingXL,
          vertical: AppSizes.spacingMD,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: AppSizes.textMD,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
