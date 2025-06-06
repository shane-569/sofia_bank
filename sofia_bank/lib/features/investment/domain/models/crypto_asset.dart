class CryptoAsset {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double marketCap;
  final double priceChangePercentage24h;
  final String imageUrl;
  final List<PricePoint> priceHistory;

  CryptoAsset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
    required this.imageUrl,
    required this.priceHistory,
  });

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice: json['current_price'].toDouble(),
      marketCap: json['market_cap'].toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h'].toDouble(),
      imageUrl: json['image'],
      priceHistory: (json['price_history'] as List)
          .map((point) => PricePoint.fromJson(point))
          .toList(),
    );
  }
}

class PricePoint {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;

  PricePoint({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory PricePoint.fromJson(Map<String, dynamic> json) {
    return PricePoint(
      timestamp: DateTime.parse(json['timestamp']),
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
    );
  }
}
