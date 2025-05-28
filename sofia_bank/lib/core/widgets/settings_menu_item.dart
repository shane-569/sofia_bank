import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class SettingsMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Icon(
                  icon,
                  color: AppColors.orange,
                ),
              ],
            ),
          ),
          if (showDivider)
            const Divider(
              height: 0.0,
              color: AppColors.orange,
            ),
        ],
      ),
    );
  }
}
