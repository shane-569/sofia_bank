import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/routes/app_routes.dart'; // Import AppRoutes

class TransactionConfirmedModal extends StatelessWidget {
  const TransactionConfirmedModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background, // Dark background for modal
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle, // Checkmark icon
            color: Colors.green, // Green color for success
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'Transaction Confirmed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae id amet ut sit duis', // Placeholder text
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the modal
              // Add a small delay before navigating
              Future.delayed(const Duration(milliseconds: 50), () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.cryptoTrading,
                  (route) => false, // Remove all routes until CryptoTradingPage
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Primary color button
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
