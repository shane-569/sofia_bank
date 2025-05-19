import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/quick_action_entity.dart';

class QuickActionGridItem extends StatelessWidget {
  final QuickActionEntity action;

  const QuickActionGridItem({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Handle action tap
          },
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.spacingSM),
                  decoration: BoxDecoration(
                    color: action.backgroundColor,
                    borderRadius:
                        BorderRadius.circular(AppSizes.cardBorderRadius),
                  ),
                  child: Icon(
                    action.icon,
                    color: action.iconColor,
                    size: AppSizes.iconMD,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingMD),
                Text(
                  action.title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: AppSizes.textMD,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.spacingXS),
                Text(
                  action.subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.textSM,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
