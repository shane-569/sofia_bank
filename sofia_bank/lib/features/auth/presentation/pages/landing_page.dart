import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';
import 'package:sofia_bank/core/theme/app_text_theme.dart';
import 'package:sofia_bank/features/common/widgets/circular_button.dart';

import '../../../../core/constants/app_assets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  // Card icon
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.mockCard,
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        fit: BoxFit.fitWidth,
                      ),
                      SvgPicture.asset(
                        color: AppColors.background,
                        AppAssets.halfBubble,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 100,
                        left: 220,
                        child: SvgPicture.asset(
                          color: AppColors.background,
                          AppAssets.bigBubble,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.xl),
                  // Title
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.lg),
                    child: Column(
                      children: [
                        Text(
                          'Jane Cooper',
                          style: AppTextTheme.textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.md),
                        // Description
                        Text(
                          'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam.',
                          style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.xl),
                        // Get Started Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircularButton(
                              backgroundColor: Colors.white,
                              iconColor: AppColors.primary,
                              size: AppDimensions.buttonHeightMd,
                              icon: Icons.arrow_forward,
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
