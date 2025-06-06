import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  CryptoCubit() : super(CryptoInitial());

  Future<void> loadCryptoAssets() async {
    emit(CryptoLoading());

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock data
      final mockAssets = [
        CryptoAsset(
          id: 'bitcoin',
          symbol: 'BTC',
          name: 'Bitcoin',
          currentPrice: 65432.10,
          marketCap: 1250000000000,
          priceChangePercentage24h: 2.5,
          imageUrl:
              'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
          priceHistory: _generateMockPriceHistory(),
        ),
        CryptoAsset(
          id: 'ethereum',
          symbol: 'ETH',
          name: 'Ethereum',
          currentPrice: 3456.78,
          marketCap: 415000000000,
          priceChangePercentage24h: -1.2,
          imageUrl:
              'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
          priceHistory: _generateMockPriceHistory(),
        ),
        CryptoAsset(
          id: 'cardano',
          symbol: 'ADA',
          name: 'Cardano',
          currentPrice: 0.45,
          marketCap: 15800000000,
          priceChangePercentage24h: 5.7,
          imageUrl:
              'https://assets.coingecko.com/coins/images/975/large/cardano.png',
          priceHistory: _generateMockPriceHistory(),
        ),
      ];

      emit(CryptoLoaded(assets: mockAssets, selectedAsset: mockAssets.first));
    } catch (e) {
      emit(CryptoError('Failed to load crypto assets: $e'));
    }
  }

  void selectAsset(CryptoAsset asset) {
    if (state is CryptoLoaded) {
      final currentState = state as CryptoLoaded;
      emit(CryptoLoaded(
        assets: currentState.assets,
        selectedAsset: asset,
      ));
    }
  }

  List<PricePoint> _generateMockPriceHistory() {
    final now = DateTime.now();
    final List<PricePoint> history = [];
    double basePrice = 100.0;

    for (int i = 0; i < 30; i++) {
      final timestamp = now.subtract(Duration(days: 29 - i));

      // Generate random price movements
      final volatility = 0.02; // 2% daily volatility
      final random = (i % 3 - 1) * volatility;
      basePrice *= (1 + random);

      // Generate OHLC data
      final open = basePrice;
      final close = basePrice * (1 + (random * 0.5));
      final high = basePrice * (1 + (random * 1.2));
      final low = basePrice * (1 - (random * 0.8));

      history.add(PricePoint(
        timestamp: timestamp,
        open: open,
        high: high,
        low: low,
        close: close,
      ));
    }

    return history;
  }
}
