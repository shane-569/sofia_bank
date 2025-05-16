import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';

import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/deposits/domain/entities/deposit_entity.dart';

class DepositCard extends StatelessWidget {
  const DepositCard({
    super.key,
    required this.deposit,
    required this.index,
  });

  final DepositEntity deposit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.spacingXL),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.text.withOpacity(0.1),
              blurRadius: AppSizes.cardShadowBlur,
              offset: const Offset(0, AppSizes.cardShadowOffset),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/userdeposits');
            },
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // Background Rupee Symbol
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Transform.rotate(
                    angle: 45 * (3.14159 / 180), // 45 degrees in radians
                    child: SvgPicture.asset(
                      AppAssets.rupeeSymbol,
                      width: 120,
                      height: 120,
                      colorFilter: ColorFilter.mode(
                        AppColors.primary.withOpacity(0.05),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                // Card Content
                Padding(
                  padding: const EdgeInsets.all(AppSizes.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            deposit.name.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: AppSizes.textLG,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacingMD,
                              vertical: AppSizes.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  AppSizes.cardBorderRadius),
                            ),
                            child: Text(
                              '${deposit.interestRate}% p.a.',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: AppSizes.textSM,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingMD),
                      Text(
                        'Min Amount: ₹${deposit.minAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppSizes.textMD,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingXS),
                      Text(
                        'Tenure: ${deposit.minTenure}-${deposit.maxTenure} months',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppSizes.textMD,
                        ),
                      ),
                      SizedBox(height: AppSizes.spacingMD),
                      Wrap(
                        spacing: AppSizes.spacingSM,
                        runSpacing: AppSizes.spacingSM,
                        children: deposit.features.take(2).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.spacingSM,
                              vertical: AppSizes.spacingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(
                                  AppSizes.cardBorderRadius / 2),
                            ),
                            child: Text(
                              feature,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppSizes.textSM,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
