import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../cubit/all_quick_actions_cubit.dart';
import '../cubit/all_quick_actions_state.dart';

import '../widgets/quick_action_grid_item.dart';
import '../widgets/quick_action_item.dart';

class AllQuickActionsPage extends StatelessWidget {
  const AllQuickActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllQuickActionsCubit()..loadQuickActions(),
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
            'Instant Services',
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<AllQuickActionsCubit, AllQuickActionsState>(
            builder: (context, state) {
              if (state.status == AllQuickActionsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == AllQuickActionsStatus.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? 'An error occurred',
                    style: const TextStyle(color: AppColors.error),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.spacingXL),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spacing2XL,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSizes.spacingLG,
                        crossAxisSpacing: AppSizes.spacingLG,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: state.actions.length,
                      itemBuilder: (context, index) {
                        final action = state.actions[index];
                        return QuickActionGridItem(action: action);
                      },
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
