import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/features/cards/domain/entities/card_entity.dart';

class CardBack extends StatelessWidget {
  final CardEntity card;
  final Color cardColor;

  const CardBack({
    Key? key,
    required this.card,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: AppSizes.cardShadowBlur,
            offset: const Offset(0, AppSizes.cardShadowOffset),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.spacingXL),
          Container(
            height: 40,
            color: Colors.black87,
          ),
          const SizedBox(height: AppSizes.spacingXL),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingXL),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white70,
                  ),
                ),
                Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    card.cvv,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: AppSizes.textLG,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
