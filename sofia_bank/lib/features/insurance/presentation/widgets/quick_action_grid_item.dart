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
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: action.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      action.icon,
                      color: action.iconColor,
                      size: AppSizes.iconLG,
                    ),
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
                  textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
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
