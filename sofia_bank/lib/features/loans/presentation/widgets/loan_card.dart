import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final VoidCallback? onTap;

  const LoanCard({
    Key? key,
    required this.loan,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₹ ');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      color: AppColors.white70,
      elevation: 4,
      shadowColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: loan.status.color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loan.type,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  _buildStatusChip(),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currencyFormat.format(loan.amount),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    label: 'Interest Rate',
                    value: '${loan.interestRate}%',
                  ),
                  _buildInfoColumn(
                    label: 'Tenure',
                    value: '${loan.tenure} months',
                  ),
                  if (loan.emi != null)
                    _buildInfoColumn(
                      label: 'EMI',
                      value: currencyFormat.format(loan.emi),
                    ),
                ],
              ),
              if (loan.amountPaid != null) ...[
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: loan.amountPaid! / loan.amount,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(loan.status.color),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount Paid',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      '${(loan.amountPaid! / loan.amount * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: loan.status.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    label: 'Start Date',
                    value: dateFormat.format(loan.startDate),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  if (loan.endDate != null)
                    _buildInfoColumn(
                      label: 'End Date',
                      value: dateFormat.format(loan.endDate!),
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: loan.status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        loan.status.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: loan.status.color,
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required String label,
    required String value,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
