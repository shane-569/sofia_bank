import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';

class CryptoPriceChart extends StatelessWidget {
  final List<PricePoint> priceHistory;
  final bool isPositive;

  const CryptoPriceChart({
    Key? key,
    required this.priceHistory,
    required this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.1),
                  strokeWidth: 0.5,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.1),
                  strokeWidth: 0.5,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '\$${value.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < priceHistory.length) {
                      final date = priceHistory[value.toInt()].timestamp;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${date.day}/${date.month}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
            ),
            lineBarsData: [
              // Candlestick wicks (high-low range)
              LineChartBarData(
                spots: priceHistory.asMap().entries.map((entry) {
                  final point = entry.value;
                  return FlSpot(
                    entry.key.toDouble(),
                    point.high,
                  );
                }).toList(),
                isCurved: false,
                color: Colors.transparent,
                barWidth: 0,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              // Candlestick bodies (open-close range)
              LineChartBarData(
                spots: priceHistory.asMap().entries.map((entry) {
                  final point = entry.value;
                  final isPositive = point.close >= point.open;
                  return FlSpot(
                    entry.key.toDouble(),
                    point.close,
                  );
                }).toList(),
                isCurved: false,
                color: isPositive ? Colors.green : Colors.red,
                barWidth: 2,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: (isPositive ? Colors.green : Colors.red)
                      .withOpacity(0.05),
                ),
              ),
            ],
            minY:
                priceHistory.map((e) => e.low).reduce((a, b) => a < b ? a : b) *
                    0.95,
            maxY: priceHistory
                    .map((e) => e.high)
                    .reduce((a, b) => a > b ? a : b) *
                1.05,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey[800]!,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 8,
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final point = priceHistory[barSpot.x.toInt()];
                    return LineTooltipItem(
                      'Open: \$${point.open.toStringAsFixed(2)}\n'
                      'High: \$${point.high.toStringAsFixed(2)}\n'
                      'Low: \$${point.low.toStringAsFixed(2)}\n'
                      'Close: \$${point.close.toStringAsFixed(2)}',
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    );
                  }).toList();
                },
              ),
              handleBuiltInTouches: true,
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return TouchedSpotIndicatorData(
                    FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                    FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 2,
                          color: isPositive ? Colors.green : Colors.red,
                          strokeWidth: 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
