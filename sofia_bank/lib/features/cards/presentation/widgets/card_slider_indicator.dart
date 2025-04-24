import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class CardSliderIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double width;

  const CardSliderIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    this.width = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.sliderIndicatorHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: AppSizes.spacingXS),
            width: isActive ? width : AppSizes.sliderIndicatorWidth,
            height: AppSizes.sliderIndicatorHeight,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.2),
              borderRadius:
                  BorderRadius.circular(AppSizes.sliderIndicatorHeight / 2),
            ),
          );
        }),
      ),
    );
  }
}
