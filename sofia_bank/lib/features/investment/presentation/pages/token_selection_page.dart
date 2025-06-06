import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/token_selection_cubit.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/token_selection_state.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/token_selection_list_item.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart'; // Import CryptoAsset
import 'package:sofia_bank/core/routes/app_routes.dart'; // Import AppRoutes

// This widget will now serve as the content for the bottom sheet
class TokenSelectionBottomSheet extends StatelessWidget {
  const TokenSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenSelectionCubit()..loadTokens(),
      child: const TokenSelectionContentView(),
    );
  }
}

// Content view for the token selection bottom sheet
class TokenSelectionContentView extends StatelessWidget {
  const TokenSelectionContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.8, // Set height to 80% of screen height
      decoration: BoxDecoration(
        color: AppColors.background, // Dark background for the bottom sheet
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            height: 4.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          // Title
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Select Token',
              style: TextStyle(
                color: AppColors.primary, // Primary color title
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (query) =>
                  context.read<TokenSelectionCubit>().filterTokens(query),
              decoration: InputDecoration(
                hintText: 'Search Token',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800], // Dark background for search field
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
              ),
              style: const TextStyle(color: Colors.white), // White text input
            ),
          ),
          const SizedBox(height: 8.0),
          // Token List
          Expanded(
            child: BlocBuilder<TokenSelectionCubit, TokenSelectionState>(
              builder: (context, state) {
                if (state is TokenSelectionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is TokenSelectionError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is TokenSelectionLoaded) {
                  return ListView.builder(
                    itemCount: state.filteredTokens.length,
                    itemBuilder: (context, index) {
                      final asset = state.filteredTokens[index];
                      return TokenSelectionListItem(
                        asset: asset,
                        onTap: () {
                          // Close the bottom sheet and navigate to confirmation page
                          Navigator.pop(context); // Close bottom sheet
                          // TODO: Pass selected token and recipient data
                          Navigator.pushNamed(
                            context,
                            AppRoutes.sendConfirmation,
                            arguments: asset, // Pass the selected asset for now
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
