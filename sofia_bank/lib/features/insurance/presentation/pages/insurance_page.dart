import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../widgets/insurance_card.dart';
import '../widgets/wellness_section.dart';
import '../widgets/quick_actions_section.dart';

class InsurancePage extends StatefulWidget {
  const InsurancePage({super.key});

  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InsuranceCubit()..loadInsurances(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.text),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'My Insurance',
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                // TODO: Implement notifications
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<InsuranceCubit, InsuranceState>(
            builder: (context, state) {
              if (state.status == InsuranceStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == InsuranceStatus.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? 'An error occurred',
                    style: const TextStyle(color: AppColors.error),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.insurances.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No active insurance policies',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppSizes.textLG,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingXL),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Navigate to new insurance page
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacing2XL,
                                  vertical: AppSizes.spacingLG,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.buttonBorderRadius,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Get Insurance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSizes.textLG,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          SizedBox(
                            height: 260,
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                context
                                    .read<InsuranceCubit>()
                                    .updateSelectedIndex(index);
                              },
                              itemCount: state.insurances.length,
                              itemBuilder: (context, index) {
                                return InsuranceCard(
                                  insurance: state.insurances[index],
                                  index: index,
                                );
                              },
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSizes.spacing2XL,
                              ),
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: state.insurances.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: AppColors.primary,
                                  dotColor: AppColors.primary.withOpacity(0.2),
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 4,
                                  expansionFactor: 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    WellnessSection(categories: state.wellnessCategories),
                    const SizedBox(height: AppSizes.spacingLG),
                    QuickActionsSection(actions: state.quickActions),
                    const SizedBox(height: AppSizes.spacingLG),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
