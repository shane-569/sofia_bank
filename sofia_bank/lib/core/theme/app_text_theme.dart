import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class AppTextTheme {
  static const String fontFamily = 'Poppins';

  static TextTheme get textTheme => const TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // Title styles
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // Body styles
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),

        // Label styles
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      );

  // Custom text styles
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
