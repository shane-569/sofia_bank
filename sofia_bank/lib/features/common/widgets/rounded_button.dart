import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';
import 'package:sofia_bank/core/theme/app_text_theme.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final EdgeInsets? padding;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? Colors.white),
          foregroundColor:
              textColor ?? (isOutlined ? Colors.white : AppColors.primary),
          elevation: isOutlined ? 0 : 1,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? AppDimensions.radiusXl),
            side: isOutlined
                ? BorderSide(color: backgroundColor ?? Colors.white)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppTextTheme.textTheme.labelLarge?.copyWith(
                      color: textColor ??
                          (isOutlined ? Colors.white : AppColors.primary),
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: AppDimensions.sm),
                    Icon(
                      icon,
                      size: 20,
                      color: textColor ??
                          (isOutlined ? Colors.white : AppColors.primary),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
