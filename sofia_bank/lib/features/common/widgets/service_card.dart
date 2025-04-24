import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.date,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.gradientStart,
                      AppColors.background,
                    ],
                  ),
                ),
              ),
              SvgPicture.asset(
                imagePath,
                width: MediaQuery.of(context).size.width,
                height: 160,
                fit: BoxFit.fill,
                color: AppColors.background,
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   right: 16,
              //   bottom: 16,
              //   child: Container(
              //     height: 40,
              //     width: 40,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: const Icon(
              //       Icons.play_arrow_rounded,
              //       color: AppColors.primary,
              //       size: 24,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
