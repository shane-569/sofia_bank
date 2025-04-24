import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/cards/domain/enums/card_status.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/card_settings_cubit.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/card_settings_state.dart';

class CardSettingsPage extends StatelessWidget {
  final String cardId;

  const CardSettingsPage({
    Key? key,
    required this.cardId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardSettingsCubit()..loadCardSettings(cardId),
      child: const CardSettingsView(),
    );
  }
}

class CardSettingsView extends StatelessWidget {
  const CardSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Card Settings',
          style: TextStyle(
            color: Colors.black87,
            fontSize: AppSizes.textXL,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<CardSettingsCubit, CardSettingsState>(
        builder: (context, state) {
          if (state.status == CardSettingsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == CardSettingsStatus.failure) {
            return Center(
                child: Text(state.errorMessage ?? 'An error occurred'));
          }

          if (state.settings == null) {
            return const Center(child: Text('No settings found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardStatusSection(context, state),
                const SizedBox(height: AppSizes.spacingXL),
                _buildLimitsSection(context, state),
                const SizedBox(height: AppSizes.spacingXL),
                _buildSecuritySection(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardStatusSection(
      BuildContext context, CardSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Status',
          style: TextStyle(
            fontSize: AppSizes.textLG,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              RadioListTile<CardStatus>(
                value: CardStatus.active,
                groupValue: state.settings!.status,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateCardStatus(CardStatus.active),
                title: const Text('Active'),
                subtitle: const Text('Card is fully functional'),
              ),
              RadioListTile<CardStatus>(
                value: CardStatus.blocked,
                groupValue: state.settings!.status,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateCardStatus(CardStatus.blocked),
                title: const Text('Blocked'),
                subtitle: const Text('Temporarily block all transactions'),
              ),
              RadioListTile<CardStatus>(
                value: CardStatus.deactivated,
                groupValue: state.settings!.status,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateCardStatus(CardStatus.deactivated),
                title: const Text('Deactivated'),
                subtitle: const Text('Permanently deactivate this card'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLimitsSection(BuildContext context, CardSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction Limits',
          style: TextStyle(
            fontSize: AppSizes.textLG,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Container(
          padding: const EdgeInsets.all(AppSizes.spacingLG),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildLimitSlider(
                context: context,
                title: 'Online Transactions',
                value: state.settings!.onlineLimit,
                max: 10000,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateLimit(onlineLimit: value),
              ),
              const SizedBox(height: AppSizes.spacingLG),
              _buildLimitSlider(
                context: context,
                title: 'POS Transactions',
                value: state.settings!.posLimit,
                max: 5000,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateLimit(posLimit: value),
              ),
              const SizedBox(height: AppSizes.spacingLG),
              _buildLimitSlider(
                context: context,
                title: 'Transfer Limit',
                value: state.settings!.transferLimit,
                max: 20000,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .updateLimit(transferLimit: value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLimitSlider({
    required BuildContext context,
    required String title,
    required double value,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: AppSizes.textMD,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$${value.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: AppSizes.textMD,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: max,
          divisions: 20,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSecuritySection(BuildContext context, CardSettingsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security Settings',
          style: TextStyle(
            fontSize: AppSizes.textLG,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SwitchListTile(
                value: state.settings!.contactlessEnabled,
                onChanged: (value) =>
                    context.read<CardSettingsCubit>().toggleContactless(value),
                title: const Text('Contactless Payments'),
                subtitle:
                    const Text('Enable or disable contactless transactions'),
              ),
              SwitchListTile(
                value: state.settings!.onlineTransactionsEnabled,
                onChanged: (value) => context
                    .read<CardSettingsCubit>()
                    .toggleOnlineTransactions(value),
                title: const Text('Online Transactions'),
                subtitle: const Text('Enable or disable online purchases'),
              ),
              ListTile(
                leading: const Icon(Icons.replay_circle_filled,
                    color: Colors.orange),
                title: const Text('Replace Card'),
                subtitle: const Text('Request a replacement for this card'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Implement card replacement flow
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
