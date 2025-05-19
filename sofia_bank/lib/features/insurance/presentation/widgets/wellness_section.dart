import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/wellness_category_entity.dart';
import 'wellness_category_item.dart';

class WellnessSection extends StatelessWidget {
  final List<WellnessCategoryEntity> categories;

  const WellnessSection({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spacing2XL,
            vertical: AppSizes.spacingLG,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Health & Wellness',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: AppSizes.textXL,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing2XL,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: AppSizes.spacingLG,
              crossAxisSpacing: AppSizes.spacingLG,
              childAspectRatio: 0.85,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return WellnessCategoryItem(
                category: categories[index],
                onTap: () {
                  if (categories[index].title == 'Health') {
                    Navigator.pushNamed(context, '/healthInsuranceForm');
                  } else if (categories[index].title == 'Bike') {
                    Navigator.pushNamed(context, '/bike-insurance-form');
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
