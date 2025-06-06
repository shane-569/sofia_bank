import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/token_selection_state.dart';

class TokenSelectionCubit extends Cubit<TokenSelectionState> {
  TokenSelectionCubit() : super(TokenSelectionInitial());

  List<CryptoAsset> _allTokens = []; // Store all tokens

  Future<void> loadTokens() async {
    emit(TokenSelectionLoading());

    try {
      // Simulate API call delay and fetch mock data (reusing mock from CryptoCubit)
      await Future.delayed(const Duration(seconds: 1));
      _allTokens = _generateMockCryptoAssets(); // Get mock data

      emit(TokenSelectionLoaded(
        allTokens: _allTokens,
        filteredTokens: _allTokens, // Initially filtered list is all tokens
      ));
    } catch (e) {
      emit(TokenSelectionError('Failed to load tokens: $e'));
    }
  }

  void filterTokens(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final filteredList = _allTokens.where((token) {
      return token.name.toLowerCase().contains(lowerCaseQuery) ||
          token.symbol.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    if (state is TokenSelectionLoaded) {
      final currentState = state as TokenSelectionLoaded;
      emit(TokenSelectionLoaded(
        allTokens: currentState.allTokens,
        filteredTokens: filteredList,
        searchQuery: query,
      ));
    }
  }

  // Reused mock data generation from CryptoCubit
  List<CryptoAsset> _generateMockCryptoAssets() {
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
        priceHistory: history,
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
        priceHistory: history,
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
        priceHistory: history,
      ),
      CryptoAsset(
        id: 'binancecoin',
        symbol: 'BNB',
        name: 'BNB',
        currentPrice: 300.0,
        marketCap: 50000000000,
        priceChangePercentage24h: 0.8,
        imageUrl:
            'https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png',
        priceHistory: history,
      ),
      CryptoAsset(
        id: 'polygon',
        symbol: 'MATIC',
        name: 'Polygon',
        currentPrice: 0.75,
        marketCap: 7000000000,
        priceChangePercentage24h: 3.1,
        imageUrl:
            'https://assets.coingecko.com/coins/images/10471/large/matic-token-icon.png',
        priceHistory: history,
      ),
      CryptoAsset(
        id: 'ripple',
        symbol: 'XRP',
        name: 'XRP',
        currentPrice: 0.50,
        marketCap: 25000000000,
        priceChangePercentage24h: -0.5,
        imageUrl: 'https://assets.coingecko.com/coins/images/447/large/XRP.png',
        priceHistory: history,
      ),
    ];

    return mockAssets;
  }
}
