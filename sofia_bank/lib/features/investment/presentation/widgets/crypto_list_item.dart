import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoAsset asset;
  final bool isSelected;
  final VoidCallback onTap;

  const CryptoListItem({
    Key? key,
    required this.asset,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPositive = asset.priceChangePercentage24h >= 0;

    return GestureDetector(
      onTap: () {
        // Navigate to CryptoDetailsPage with the selected asset
        Navigator.pushNamed(context, AppRoutes.cryptoDetails, arguments: asset);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? AppColors.primary : Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(asset.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    asset.symbol.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 40,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: asset.priceHistory.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          entry.value.close,
                        );
                      }).toList(),
                      isCurved: true,
                      color: isPositive ? Colors.green : Colors.red,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minY: asset.priceHistory
                          .map((e) => e.low)
                          .reduce((a, b) => a < b ? a : b) *
                      0.95,
                  maxY: asset.priceHistory
                          .map((e) => e.high)
                          .reduce((a, b) => a > b ? a : b) *
                      1.05,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${asset.currentPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}${asset.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
