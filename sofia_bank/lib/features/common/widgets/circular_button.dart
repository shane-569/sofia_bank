import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final EdgeInsets? padding;
  final double? elevation;

  const CircularButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.padding,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 50;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? Colors.white),
          foregroundColor:
              iconColor ?? (isOutlined ? Colors.white : AppColors.primary),
          elevation: elevation,
          padding: padding ?? EdgeInsets.zero,
          shape: CircleBorder(
            side: isOutlined
                ? BorderSide(color: backgroundColor ?? Colors.white)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: buttonSize * 0.5,
                width: buttonSize * 0.5,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    iconColor ??
                        (isOutlined ? Colors.white : AppColors.primary),
                  ),
                ),
              )
            : Icon(
                icon ?? Icons.arrow_forward,
                size: buttonSize * 0.4,
                color: iconColor ??
                    (isOutlined ? Colors.white : AppColors.primary),
              ),
      ),
    );
  }
}
