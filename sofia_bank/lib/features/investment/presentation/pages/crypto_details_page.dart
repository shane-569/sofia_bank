import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/crypto_price_chart.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptoAsset asset;

  const CryptoDetailsPage({Key? key, required this.asset}) : super(key: key);

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  String selectedTimeRange = '1d';

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.asset.priceChangePercentage24h >= 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(widget.asset.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.asset.symbol.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0.19873 ${widget.asset.symbol.toUpperCase()}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$3.00912',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const Text(
                                '(+0.68%)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 0.2,
                    child: SvgPicture.asset(
                      AppAssets.wavey,
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            // Current Price and 24h Change
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.asset.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isPositive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isPositive ? Colors.green : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${isPositive ? '+' : ''}${widget.asset.priceChangePercentage24h.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: isPositive ? Colors.green : Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price Chart
            CryptoPriceChart(
              priceHistory: widget.asset.priceHistory,
              isPositive: isPositive,
            ),

            // Time Range Buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTimeRangeButton('1m'),
                  _buildTimeRangeButton('5m'),
                  _buildTimeRangeButton('15m'),
                  _buildTimeRangeButton('1h'),
                  _buildTimeRangeButton('1d'),
                  _buildTimeRangeButton('More'),
                ],
              ),
            ),

            // Available Balance

            // Info Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[800]?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Market Cap',
                      '\$${widget.asset.marketCap.toStringAsFixed(2)}'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Circulating Supply', '10M'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Max Supply', '15M'),
                ],
              ),
            ),

            // Trade Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement trade functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Trade',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeButton(String text) {
    final isSelected = selectedTimeRange == text;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              selectedTimeRange = text;
            });
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : AppColors.primary,
            backgroundColor:
                isSelected ? AppColors.primary : Colors.transparent,
            side: BorderSide(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
