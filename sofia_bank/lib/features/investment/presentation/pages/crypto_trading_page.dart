import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/crypto_cubit.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/crypto_state.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/crypto_list_item.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/crypto_price_chart.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/action_button.dart';

class CryptoTradingPage extends StatelessWidget {
  const CryptoTradingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CryptoCubit()..loadCryptoAssets(),
      child: const CryptoTradingView(),
    );
  }
}

class CryptoTradingView extends StatelessWidget {
  const CryptoTradingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Crypto Trading',
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
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
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
            return _buildLoadedView(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedView(BuildContext context, CryptoLoaded state) {
    final selectedAsset = state.selectedAsset!;
    final isPositive = selectedAsset.priceChangePercentage24h >= 0;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(selectedAsset.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedAsset.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedAsset.symbol.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                '\$${selectedAsset.currentPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${isPositive ? '+' : ''}${selectedAsset.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16,
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '24h',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                iconPath: 'assets/icons/send.svg',
                text: 'Send',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.send);
                },
              ),
              ActionButton(
                iconPath: 'assets/icons/recieve.svg',
                text: 'Receive',
                onTap: () {
                  // TODO: Implement Receive functionality
                },
              ),
              ActionButton(
                iconPath: 'assets/icons/swap.svg',
                text: 'Swap',
                onTap: () {
                  // TODO: Implement Swap functionality
                },
              ),
            ],
          ),
        ),
        CryptoPriceChart(
          priceHistory: selectedAsset.priceHistory,
          isPositive: isPositive,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Assets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.topMovers);
                },
                child: const Text('View all'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: state.assets.length,
            itemBuilder: (context, index) {
              final asset = state.assets[index];
              return CryptoListItem(
                asset: asset,
                isSelected: asset.id == selectedAsset.id,
                onTap: () {
                  context.read<CryptoCubit>().selectAsset(asset);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
