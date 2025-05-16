import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/deposits/presentation/cubit/user_deposits_cubit.dart';
import 'package:sofia_bank/features/deposits/presentation/cubit/user_deposits_state.dart';
import 'package:sofia_bank/features/deposits/presentation/widgets/user_deposit_card.dart';

class UserDepositsPage extends StatefulWidget {
  const UserDepositsPage({super.key});

  @override
  State<UserDepositsPage> createState() => _UserDepositsPageState();
}

class _UserDepositsPageState extends State<UserDepositsPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserDepositsCubit()..loadUserDeposits(),
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
            'My Deposits',
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<UserDepositsCubit, UserDepositsState>(
            builder: (context, state) {
              if (state.status == UserDepositsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == UserDepositsStatus.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? 'An error occurred',
                    style: const TextStyle(color: AppColors.error),
                  ),
                );
              }

              if (state.deposits.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No active deposits',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppSizes.textLG,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingXL),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to new deposit page
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
                          'Open New Deposit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.textLG,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Stack(
                children: [
                  // Deposits Slider
                  Container(
                    height: 260,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        context
                            .read<UserDepositsCubit>()
                            .updateSelectedIndex(index);
                      },
                      itemCount: state.deposits.length,
                      itemBuilder: (context, index) {
                        return UserDepositCard(
                          deposit: state.deposits[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                  // Page Indicator
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: AppSizes.spacing2XL,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: state.deposits.length,
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
                  // New Deposit Button
                  Positioned(
                    right: AppSizes.spacing2XL,
                    top: AppSizes.spacing2XL,
                    child: FloatingActionButton(
                      onPressed: () {
                        // TODO: Navigate to new deposit page
                      },
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
