import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/crypto_cubit.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/crypto_state.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/crypto_list_item.dart';

class TopMoversPage extends StatelessWidget {
  const TopMoversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Top movers',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Token',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: BlocBuilder<CryptoCubit, CryptoState>(
              builder: (context, state) {
                if (state is CryptoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state is CryptoError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is CryptoLoaded) {
                  return ListView.builder(
                    itemCount: state.assets.length,
                    itemBuilder: (context, index) {
                      final asset = state.assets[index];
                      // We'll use CryptoListItem for now, might need a different widget later
                      return CryptoListItem(
                        asset: asset,
                        isSelected: false, // No selection on this page
                        onTap: () {
                          // TODO: Implement navigation to detail page
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
