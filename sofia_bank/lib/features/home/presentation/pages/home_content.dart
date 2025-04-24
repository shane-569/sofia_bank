import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/network/network_service.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';
import 'package:sofia_bank/core/theme/app_text_theme.dart';
import 'package:sofia_bank/features/home/presentation/cubit/home_cubit.dart';
import 'package:sofia_bank/features/home/presentation/cubit/home_state.dart';
import 'package:sofia_bank/features/home/presentation/widgets/action_button.dart';
import 'package:sofia_bank/features/home/presentation/widgets/payment_option.dart';
import 'package:sofia_bank/features/home/presentation/widgets/promo_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(NetworkService())..fetchBalance(),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: AppDimensions.lg),
          _buildQuickActions(),
          const SizedBox(height: AppDimensions.xl),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPaymentList(),
                    const SizedBox(height: AppDimensions.xl),
                    _buildPromoSection(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.lg),
          const Text(
            'Available Balance',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: AppDimensions.sm),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Text(
                '\$${state.balance.toStringAsFixed(2)}',
                style: AppTextTheme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          icon: Icons.account_balance_wallet,
          label: 'Top Up',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.send,
          label: 'Send',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.request_page,
          label: 'Request',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.history,
          label: 'History',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPaymentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment List',
          style: AppTextTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 3 * AppDimensions.lg) / 4;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: AppDimensions.lg,
              crossAxisSpacing: AppDimensions.lg,
              childAspectRatio: itemWidth / (itemWidth + 24),
              children: [
                PaymentOption(
                  icon: Icons.wifi,
                  label: 'Internet',
                  color: Colors.red[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.flash_on,
                  label: 'Electricity',
                  color: Colors.yellow[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.card_giftcard,
                  label: 'Voucher',
                  color: Colors.green[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.security,
                  label: 'Assurance',
                  color: Colors.blue[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.phone_android,
                  label: 'Mobile\nCredit',
                  color: Colors.purple[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.receipt,
                  label: 'Bill',
                  color: Colors.indigo[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.shopping_cart,
                  label: 'Merchant',
                  color: Colors.pink[100]!,
                  onTap: () {},
                ),
                PaymentOption(
                  icon: Icons.more_horiz,
                  label: 'More',
                  color: Colors.grey[200]!,
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Promo & Discount',
              style: AppTextTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See more',
                style: TextStyle(color: AppColors.secondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PromoCard(
                title: "Special Offer for Today's Top Up",
                subtitle: 'Get discount for every top up',
                color: AppColors.primary,
                onTap: () {},
              ),
              const SizedBox(width: AppDimensions.md),
              PromoCard(
                title: 'Weekend Special Deals',
                subtitle: 'Save more on weekends',
                color: AppColors.secondary,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
