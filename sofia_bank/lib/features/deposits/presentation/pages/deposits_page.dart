import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/deposits/presentation/cubit/deposits_cubit.dart';
import 'package:sofia_bank/features/deposits/presentation/cubit/deposits_state.dart';
import 'package:sofia_bank/features/deposits/presentation/widgets/deposit_card.dart';

class DepositsPage extends StatelessWidget {
  const DepositsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DepositsCubit()..loadDeposits(),
      child: const DepositsView(),
    );
  }
}

class DepositsView extends StatelessWidget {
  const DepositsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<DepositsCubit, DepositsState>(
          builder: (context, state) {
            if (state.status == DepositsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == DepositsStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'An error occurred',
                  style: const TextStyle(color: AppColors.error),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  backgroundColor: AppColors.background,
                  title: Text(
                    'Deposits',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: AppSizes.textXL,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  floating: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSizes.spacing2XL),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.deposits.length) return null;
                        return DepositCard(
                          deposit: state.deposits[index],
                          index: index,
                        );
                      },
                      childCount: state.deposits.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
