import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class InvestmentSummary extends StatelessWidget {
  const InvestmentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Portfolio Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  'Total Investment',
                  '₹1,25,000',
                  Icons.account_balance_wallet,
                ),
                _buildSummaryItem(
                  'Current Value',
                  '₹1,45,000',
                  Icons.trending_up,
                ),
                _buildSummaryItem(
                  'Returns',
                  '+16%',
                  Icons.percent,
                  isPositive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon, {
    bool isPositive = false,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isPositive ? Colors.green : AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
