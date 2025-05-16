import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/wellness_category_entity.dart';

class WellnessCategoryItem extends StatelessWidget {
  final WellnessCategoryEntity category;
  final VoidCallback? onTap;

  const WellnessCategoryItem({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacingSM),
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.spacingSM),
              decoration: BoxDecoration(
                color: category.iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              ),
              child: Icon(
                category.icon,
                color: category.iconColor,
                size: AppSizes.iconLG,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Text(
              category.title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: AppSizes.textSM,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
