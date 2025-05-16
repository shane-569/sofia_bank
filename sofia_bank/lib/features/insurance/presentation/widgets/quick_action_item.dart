import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/quick_action_entity.dart';

class QuickActionItem extends StatelessWidget {
  final QuickActionEntity action;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacingLG),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.spacingMD),
              decoration: BoxDecoration(
                color: action.backgroundColor,
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              ),
              child: Icon(
                action.icon,
                color: action.iconColor,
                size: AppSizes.iconLG,
              ),
            ),
            const SizedBox(width: AppSizes.spacingLG),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    action.title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: AppSizes.textMD,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingXS),
                  Text(
                    action.subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppSizes.textSM,
                    ),
                  ),
                ],
              ),
            ),
            if (action.amount != null) ...[
              const SizedBox(width: AppSizes.spacingMD),
              Text(
                action.amount!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: AppSizes.textLG,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
