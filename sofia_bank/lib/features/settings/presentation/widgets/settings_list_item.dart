import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class SettingsListItem extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;
  final Color? iconColor;
  final TextStyle? titleStyle;

  const SettingsListItem({
    Key? key,
    this.leadingIcon,
    required this.title,
    this.trailing,
    this.onTap,
    this.showDivider = true,
    this.iconColor,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: leadingIcon != null
              ? Icon(
                  leadingIcon,
                  color: iconColor ?? AppColors.primary,
                  size: 24,
                )
              : null,
          title: Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
          ),
          trailing: trailing ??
              (onTap != null
                  ? const Icon(
                      Icons.chevron_right,
                      color: AppColors.primary,
                    )
                  : null),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 0.5,
            color: AppColors.textSecondary,
          ),
      ],
    );
  }
}
