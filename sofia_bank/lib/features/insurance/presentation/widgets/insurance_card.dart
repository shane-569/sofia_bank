import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/insurance_entity.dart';

class InsuranceCard extends StatelessWidget {
  const InsuranceCard({
    super.key,
    required this.insurance,
    required this.index,
  });

  final InsuranceEntity insurance;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yy');

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
              AppColors.primary,
              AppColors.primary.withOpacity(0.5),
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
          children: [
            // Background Pattern
            Positioned(
              right: -40,
              bottom: -40,
              child: Transform.rotate(
                angle: 45 * (3.14159 / 180),
                child: SvgPicture.asset(
                  AppAssets.bigBubble,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              insurance.type,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: AppSizes.textXL,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingXS),
                            Text(
                              insurance.vehicleModel.isNotEmpty
                                  ? insurance.vehicleModel
                                  : 'Comprehensive',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: AppSizes.textMD,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // TODO: Navigate to insurance details
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingXL),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Policy holder',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: AppSizes.textSM,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingXS),
                            Text(
                              insurance.policyHolder,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: AppSizes.textMD,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            insurance.policyNumber,
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
                  const SizedBox(height: AppSizes.spacingLG),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Third party validity',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: AppSizes.textSM,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingXS),
                            Text(
                              dateFormat.format(insurance.validityDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: AppSizes.textMD,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.icCardHeight,
                        width: AppSizes.icButtonWidth,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement renew functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white70,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.buttonBorderRadiusInsurance,
                              ),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Renew Now',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: AppSizes.textSM,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.sliderIndicatorWidth,
                              ),
                              Icon(
                                Icons.rotate_right_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ],
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
