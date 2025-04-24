import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/features/cards/domain/entities/transaction_entity.dart';

class TransactionDetailsPage extends StatelessWidget {
  final TransactionEntity transaction;
  final String cardNumber;

  const TransactionDetailsPage({
    Key? key,
    required this.transaction,
    required this.cardNumber,
  }) : super(key: key);

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingLG,
        vertical: AppSizes.spacingSM,
      ),
      decoration: BoxDecoration(
        color: transaction.type.toLowerCase() == 'failed'
            ? Colors.red.withOpacity(0.1)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            transaction.type.toLowerCase() == 'failed'
                ? Icons.error_outline
                : Icons.check_circle_outline,
            size: 16,
            color: transaction.type.toLowerCase() == 'failed'
                ? Colors.red
                : Colors.green,
          ),
          const SizedBox(width: AppSizes.spacingXS),
          Text(
            transaction.type.toLowerCase() == 'failed'
                ? 'Failed'
                : 'Successful',
            style: TextStyle(
              color: transaction.type.toLowerCase() == 'failed'
                  ? Colors.red
                  : Colors.green,
              fontSize: AppSizes.textSM,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferTimeline() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.spacingXL),
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(transaction.avatarUrl),
              ),
              const SizedBox(width: AppSizes.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.name,
                      style: const TextStyle(
                        fontSize: AppSizes.textLG,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          cardNumber.substring(0, 4),
                          style: TextStyle(
                            fontSize: AppSizes.textSM,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: AppSizes.spacingXS),
                        Text(
                          '•',
                          style: TextStyle(
                            fontSize: AppSizes.textSM,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: AppSizes.spacingXS),
                        Text(
                          'Card Payment',
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
                '${transaction.date.hour.toString().padLeft(2, '0')}:${transaction.date.minute.toString().padLeft(2, '0')} ${transaction.date.hour >= 12 ? 'pm' : 'am'}',
                style: TextStyle(
                  fontSize: AppSizes.textSM,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionFlow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.spacingXL),
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 2,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green,
                  Colors.green.withOpacity(0.5),
                  Colors.green.withOpacity(0.3),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingLG),
          Expanded(
            child: Column(
              children: [
                _buildTimelineItem(
                  icon: Icons.check_circle,
                  title: 'Payment Initiated',
                  subtitle: 'Transaction started',
                  time:
                      '${transaction.date.hour.toString().padLeft(2, '0')}:${transaction.date.minute.toString().padLeft(2, '0')} ${transaction.date.hour >= 12 ? 'pm' : 'am'}',
                  isCompleted: true,
                ),
                const SizedBox(height: AppSizes.spacingLG),
                _buildTimelineItem(
                  icon: Icons.account_balance,
                  title: 'Processing',
                  subtitle: 'Bank verification',
                  time:
                      '${(transaction.date.hour).toString().padLeft(2, '0')}:${(transaction.date.minute + 1).toString().padLeft(2, '0')} ${transaction.date.hour >= 12 ? 'pm' : 'am'}',
                  isCompleted: true,
                ),
                const SizedBox(height: AppSizes.spacingLG),
                _buildTimelineItem(
                  icon: Icons.check_circle_outline,
                  title: 'Completed',
                  subtitle: 'Transaction successful',
                  time:
                      '${(transaction.date.hour).toString().padLeft(2, '0')}:${(transaction.date.minute + 2).toString().padLeft(2, '0')} ${transaction.date.hour >= 12 ? 'pm' : 'am'}',
                  isCompleted: transaction.type.toLowerCase() != 'failed',
                  isFailed: transaction.type.toLowerCase() == 'failed',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
    bool isFailed = false,
  }) {
    final color = isFailed
        ? Colors.red
        : isCompleted
            ? Colors.green
            : Colors.grey;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isFailed ? Icons.error_outline : icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.textMD,
                  fontWeight: FontWeight.w500,
                  color: isFailed ? Colors.red : Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: AppSizes.textSM,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: AppSizes.textSM,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTransferDetails() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transfer Details',
            style: TextStyle(
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spacingXL),
          _buildDetailRow('Transfer ID', '#${transaction.id}'),
          _buildDetailRow('Transfer Amount', '\$${transaction.amount}'),
          _buildDetailRow('App Fee', '-\$2.00'),
          _buildDetailRow(
            'Total Amount',
            '\$${(transaction.amount + 2).toStringAsFixed(2)}',
            isTotal: true,
          ),
          const SizedBox(height: AppSizes.spacingXL),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingMD),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? AppSizes.textLG : AppSizes.textMD,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? AppSizes.textLG : AppSizes.textMD,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transcations Details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: AppSizes.textXL,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black87),
            onPressed: () {
              // Show transaction info
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSizes.spacingXL),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Handle share
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSizes.spacingLG),
                  side: const BorderSide(color: Colors.black87),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.buttonBorderRadius),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share, color: Colors.black87),
                    SizedBox(width: AppSizes.spacingMD),
                    Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppSizes.textLG,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingLG),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle transfer
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSizes.spacingLG),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.buttonBorderRadius),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    SizedBox(width: AppSizes.spacingMD),
                    Text(
                      'Transfer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSizes.textLG,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.spacingXL),
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: AppSizes.textLG,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppSizes.spacingMD),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                        fontSize: AppSizes.text2XL,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: transaction.amount.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: AppSizes.text4XL,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '.00',
                      style: TextStyle(
                        fontSize: AppSizes.text2XL,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spacingLG),
              _buildStatusChip(),
              _buildTransferTimeline(),
              _buildTransactionFlow(),
              _buildTransferDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
