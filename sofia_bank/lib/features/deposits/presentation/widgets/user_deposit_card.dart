import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/user_deposit_entity.dart';

class UserDepositCard extends StatelessWidget {
  const UserDepositCard({
    super.key,
    required this.deposit,
    required this.index,
  });

  final UserDepositEntity deposit;
  final int index;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      locale: 'en_IN',
      decimalDigits: 0,
    );

    final dateFormat = DateFormat('dd MMM yyyy');

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
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacing2XL,
          vertical: AppSizes.spacingXL,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.text.withOpacity(0.1),
              blurRadius: AppSizes.cardShadowBlur,
              offset: const Offset(0, AppSizes.cardShadowOffset),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Background Rupee Symbol
            Positioned(
              right: -40,
              bottom: -40,
              child: Transform.rotate(
                angle: 45 * (3.14159 / 180),
                child: SvgPicture.asset(
                  AppAssets.rupeeSymbol,
                  width: 160,
                  height: 160,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
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
                        deposit.depositName.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
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
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(AppSizes.cardBorderRadius),
                        ),
                        child: Text(
                          '${deposit.interestRate}% p.a.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.textSM,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingLG),
                  Text(
                    'Amount: ${currencyFormat.format(deposit.amount)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.textXL,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingMD),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: AppSizes.textSM,
                            ),
                          ),
                          const SizedBox(height: AppSizes.spacingXS),
                          Text(
                            dateFormat.format(deposit.startDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.textMD,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Maturity Date',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: AppSizes.textSM,
                            ),
                          ),
                          const SizedBox(height: AppSizes.spacingXS),
                          Text(
                            dateFormat.format(deposit.maturityDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.textMD,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingMD),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Maturity Amount',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: AppSizes.textSM,
                            ),
                          ),
                          const SizedBox(height: AppSizes.spacingXS),
                          Text(
                            currencyFormat.format(deposit.maturityAmount),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.textMD,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacingMD,
                          vertical: AppSizes.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(AppSizes.cardBorderRadius),
                        ),
                        child: Text(
                          deposit.status.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.textSM,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
