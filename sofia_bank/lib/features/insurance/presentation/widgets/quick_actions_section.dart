import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/quick_action_entity.dart';
import 'quick_action_item.dart';

class QuickActionsSection extends StatelessWidget {
  final List<QuickActionEntity> actions;

  const QuickActionsSection({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing2XL,
            vertical: AppSizes.spacingLG,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: AppSizes.textXL,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.allQuickActions);
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.textMD,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing2XL,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSizes.spacingMD),
            itemBuilder: (context, index) {
              return QuickActionItem(
                action: actions[index],
                onTap: () {
                  // TODO: Handle action tap
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
