// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/features/cards/domain/entities/card_entity.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/card_back.dart';

class BankCard extends StatefulWidget {
  final CardEntity card;
  final bool isSelected;
  final VoidCallback onTap;
  final Animation<double> animation;

  const BankCard({
    Key? key,
    required this.card,
    required this.isSelected,
    required this.onTap,
    required this.animation,
  }) : super(key: key);

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeInOut,
      ),
    );

    _flipAnimation.addListener(() {
      if (_flipAnimation.value >= 0.5 && !_showBack) {
        setState(() => _showBack = true);
      } else if (_flipAnimation.value < 0.5 && _showBack) {
        setState(() => _showBack = false);
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_flipController.isAnimating) return;
    if (_flipController.status == AnimationStatus.completed) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingMD),
        child: AnimatedBuilder(
          animation: Listenable.merge([widget.animation, _flipAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: widget.isSelected
                  ? AppSizes.scaleSelected
                  : AppSizes.scaleUnselected,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_flipAnimation.value * math.pi),
                alignment: Alignment.center,
                child: _showBack
                    ? Transform(
                        transform: Matrix4.identity()..rotateY(math.pi),
                        alignment: Alignment.center,
                        child: CardBack(
                          card: widget.card,
                          cardColor: widget.card.cardColor,
                        ),
                      )
                    : _buildFrontCard(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: widget.card.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: widget.card.cardColor.withOpacity(0.2),
            blurRadius: AppSizes.cardShadowBlur,
            offset: const Offset(0, AppSizes.cardShadowOffset),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned(
            right: -AppSizes.patternOffset,
            bottom: -AppSizes.patternOffset,
            child: Opacity(
              opacity: 0.1,
              child: SvgPicture.asset(
                AppAssets.linesCurvy,
                width: AppSizes.patternSize,
                height: AppSizes.patternSize,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // Card Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/${widget.card.type.toLowerCase()}_logo.svg',
                    width: AppSizes.logoWidth,
                    height: AppSizes.logoHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    '${widget.card.currency} ${widget.card.balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.text2XL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.card.cardNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.textLG,
                  letterSpacing: 2,
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
                        'CARD HOLDER',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: AppSizes.textXS,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingXS),
                      Text(
                        widget.card.cardHolderName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.textMD,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXPIRES',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: AppSizes.textXS,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingXS),
                      Text(
                        widget.card.expiryDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.textMD,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
