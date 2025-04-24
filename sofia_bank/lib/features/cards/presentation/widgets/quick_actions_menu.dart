import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/cards/presentation/pages/card_settings_page.dart';
import 'package:sofia_bank/features/statistics/presentation/pages/statistics_page.dart';

class QuickActionsMenu extends StatelessWidget {
  final String cardId;

  const QuickActionsMenu({
    Key? key,
    required this.cardId,
  }) : super(key: key);

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spacingSM),
        Text(
          label,
          style: TextStyle(
            fontSize: AppSizes.textSM,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingXL,
        vertical: AppSizes.spacingLG,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.swap_horiz,
            label: 'Transfer',
            onTap: () {
              // Handle transfer
            },
          ),
          _buildActionButton(
            icon: Icons.pie_chart,
            label: 'Statistics',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsPage(),
                ),
              );
            },
          ),
          _buildActionButton(
            icon: Icons.account_balance_wallet,
            label: 'Request',
            onTap: () {
              // Handle request
            },
          ),
          _buildActionButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardSettingsPage(cardId: cardId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
