import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_cubit.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_state.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/recipient_list_item.dart';
import 'package:sofia_bank/core/routes/app_routes.dart'; // Import AppRoutes
import 'package:sofia_bank/features/investment/presentation/pages/token_selection_page.dart'; // Import TokenSelectionBottomSheet

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendCubit()..loadRecipients(),
      child: const SendView(),
    );
  }
}

class SendView extends StatelessWidget {
  const SendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar background to white
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.black), // Black icon on white background
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Send',
          style: TextStyle(
            color: Colors.black, // Black title on white background
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SendCubit, SendState>(
        builder: (context, state) {
          if (state is SendLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary, // Use primary color for loader
              ),
            );
          }

          if (state is SendError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is SendLoaded) {
            return _buildLoadedView(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedView(BuildContext context, SendLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send To',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter recipient address',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  suffixIcon: Icon(Icons.content_copy, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color:
                            AppColors.primary), // Highlight with primary color
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 15.0),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // TODO: Implement add to address book functionality
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline,
                        color: AppColors.primary,
                        size: 20), // Primary color for icon
                    const SizedBox(width: 4),
                    Text(
                      'Add this to your address book',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary, // Primary color for text
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: const Text(
            'Address Book',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search recipient',
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: AppColors.primary), // Highlight with primary color
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.recipients.length,
            itemBuilder: (context, index) {
              final recipient = state.recipients[index];
              return RecipientListItem(
                recipient: recipient,
                onTap: () {
                  // TODO: Implement recipient selection
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const TokenSelectionBottomSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary, // Use primary color for button
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minimumSize:
                  const Size(double.infinity, 50), // Make button full width
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
