import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_confirmation_cubit.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_confirmation_state.dart';
import 'package:sofia_bank/features/investment/presentation/pages/transaction_confirmed_modal.dart';

class SendConfirmationPage extends StatelessWidget {
  const SendConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendConfirmationCubit()..initialize(),
      child: const SendConfirmationView(),
    );
  }
}

class SendConfirmationView extends StatelessWidget {
  const SendConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Use dark background as in image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primary), // Primary color icon
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Send',
          style: TextStyle(
            color: AppColors.primary, // Primary color title
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SendConfirmationCubit, SendConfirmationState>(
        listener: (context, state) {
          if (state is SendConfirmationLoaded && state.amountInput.isEmpty) {
            // Assuming empty input after confirm means success for this mock
            // In a real app, this would be triggered by a specific success state
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const TransactionConfirmedModal();
              },
            );
          }
        },
        builder: (context, state) {
          if (state is SendConfirmationLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is SendConfirmationError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is SendConfirmationLoaded) {
            return _buildLoadedView(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedView(BuildContext context, SendConfirmationLoaded state) {
    final cubit = context.read<SendConfirmationCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Enter Amount',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                state.amountInput.isEmpty ? '0' : state.amountInput,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Max',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary, // Use primary color for Max text
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Darker background for balance
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      // TODO: Use actual asset icon
                      backgroundColor: AppColors.primary, // Placeholder color
                      child: Text(state.selectedAssetSymbol,
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.selectedAssetSymbol,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${state.availableBalance.toStringAsFixed(2)} ${state.selectedAssetSymbol}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Number Pad
          Expanded(
            child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio:
                    1.5, // Set aspect ratio to 1.0 for circular buttons
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 12, // 1-9, ., 0, <-
              itemBuilder: (context, index) {
                final buttonText = index < 9
                    ? '${index + 1}'
                    : index == 9
                        ? '.'
                        : index == 10
                            ? '0'
                            : ''; // Backspace

                return ElevatedButton(
                  onPressed: () {
                    if (buttonText == '') {
                      cubit.deleteAmountInput();
                    } else {
                      cubit.updateAmountInput(buttonText);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background
                    foregroundColor: Colors.black, // Black text color
                    shape: const CircleBorder(), // Make the button circular
                    padding: EdgeInsets.zero, // Remove default padding
                    elevation: 4.0, // Add shadow
                    shadowColor: Colors.black.withOpacity(0.3), // Shadow color
                    minimumSize: const Size(50, 50), // Set button size to 50x50
                  ),
                  child: index == 11 // Backspace button
                      ? const Icon(
                          Icons.backspace_outlined,
                          color: Colors.black,
                          size: 24,
                        ) // Black icon, adjust size
                      : Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 24, // Adjust font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              cubit.confirmSend();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Primary color button
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minimumSize:
                  const Size(double.infinity, 50), // Make button full width
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
