import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../../domain/entities/payment_option.dart';
import '../cubit/fast_tag_wallet_cubit.dart';
import '../cubit/fast_tag_wallet_state.dart';

class FastTagWalletPage extends StatefulWidget {
  const FastTagWalletPage({super.key});

  @override
  State<FastTagWalletPage> createState() => _FastTagWalletPageState();
}

class _FastTagWalletPageState extends State<FastTagWalletPage> {
  late TextEditingController _amountController;
  double _currentAmount = 0.0; // local copy to sync with cubit state

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateAmountControllerText(double amount) {
    final newText = amount == 0.0 ? '' : amount.toStringAsFixed(0);
    if (_amountController.text != newText) {
      _amountController.text = newText;
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Tag Wallet'),
      ),
      body: BlocProvider(
        create: (context) => FastTagWalletCubit(),
        child: BlocBuilder<FastTagWalletCubit, FastTagWalletState>(
          builder: (context, state) {
            // Sync local _currentAmount with Cubit's state amount
            if (_currentAmount != state.amount) {
              _currentAmount = state.amount;
              // Update controller text after build to avoid rebuild conflicts
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _updateAmountControllerText(_currentAmount);
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Vehicle Number Section
                  const Card(
                    color: AppColors.background,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vehicle No.',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              Text(
                                'DL3CC10XX', // Placeholder, replace with actual data/widget
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Add Money Section
                  Card(
                    color: AppColors.background,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add Money to Fastag wallet',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                              prefixText: '₹ ',
                              border: OutlineInputBorder(),
                            ),
                            controller: _amountController,
                            onChanged: (value) {
                              final amount = double.tryParse(value) ?? 0.0;
                              // Only update cubit if different from current amount
                              if (amount != _currentAmount) {
                                context
                                    .read<FastTagWalletCubit>()
                                    .updateAmount(amount);
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: _buildAmountButton(context, 250)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildAmountButton(context, 500)),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: _buildAmountButton(context, 1000)),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: _buildAmountButton(context, 2000)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Payment Option Section
                  const Text(
                    'Payment Option',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _buildPaymentOptionItem(
                            context,
                            PaymentOption.upi,
                            'UPI',
                            Icons.account_balance_wallet_outlined,
                            state.selectedPaymentOption == PaymentOption.upi),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildPaymentOptionItem(
                            context,
                            PaymentOption.card,
                            'Card',
                            Icons.credit_card,
                            state.selectedPaymentOption == PaymentOption.card),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildPaymentOptionItem(
                            context,
                            PaymentOption.netBanking,
                            'Net Banking',
                            Icons.credit_score_outlined,
                            state.selectedPaymentOption ==
                                PaymentOption.netBanking),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Proceed Button
                  ElevatedButton(
                    onPressed: () {
                      final currentAmount =
                          context.read<FastTagWalletCubit>().state.amount;
                      print('Proceeding with amount: $currentAmount');
                      // TODO: Implement navigation and payment logic
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAmountButton(BuildContext context, double amount) {
    return OutlinedButton(
      onPressed: () {
        final newAmount = _currentAmount + amount;
        context.read<FastTagWalletCubit>().updateAmount(newAmount);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.orange,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        '+${amount.toInt()}',
        style: const TextStyle(
            fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPaymentOptionItem(BuildContext context, PaymentOption option,
      String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        context.read<FastTagWalletCubit>().selectPaymentOption(option);
      },
      child: Card(
        elevation: isSelected ? 4 : 1,
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isSelected
              ? BorderSide(color: AppColors.orange, width: 2)
              : BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 30,
                  color: isSelected ? AppColors.orange : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color:
                        isSelected ? AppColors.orange : Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
