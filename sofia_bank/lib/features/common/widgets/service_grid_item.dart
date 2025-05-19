import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';

class ServiceGridItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final int index;
  final bool isVisible;
  final int row;
  final int col;
  final Color backgroundColor;
  final Color iconColor;

  const ServiceGridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.index,
    required this.isVisible,
    required this.row,
    required this.col,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  State<ServiceGridItem> createState() => _ServiceGridItemState();
}

class _ServiceGridItemState extends State<ServiceGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
    ));

    final double distanceFromCenter =
        ((widget.row - 1).abs() + (widget.col - 1).abs()) / 2;

    final delay = Duration(milliseconds: (distanceFromCenter * 80).toInt());

    if (widget.isVisible) {
      Future.delayed(delay, () {
        if (mounted) {
          _controller.forward(from: 0.0);
        }
      });
    }
  }

  @override
  void didUpdateWidget(ServiceGridItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        final double distanceFromCenter =
            ((widget.row - 1).abs() + (widget.col - 1).abs()) / 2;
        final delay = Duration(milliseconds: (distanceFromCenter * 80).toInt());

        _controller.reset();
        Future.delayed(delay, () {
          if (mounted) {
            _controller.forward(from: 0.0);
          }
        });
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Opacity(
                    opacity: 0.1,
                    child: SvgPicture.asset(
                      AppAssets.linesCurvy,
                      width: 120,
                      height: 120,
                      colorFilter: ColorFilter.mode(
                        widget.backgroundColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            widget.icon,
                            color: widget.iconColor,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
