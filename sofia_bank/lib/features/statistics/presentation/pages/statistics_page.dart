import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildCashflowHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cashflow Activity',
          style: TextStyle(
            fontSize: AppSizes.textXL,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '\$84,432',
              style: TextStyle(
                fontSize: AppSizes.text4XL,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: AppSizes.spacingSM),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacingSM,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '+2%',
                style: TextStyle(
                  fontSize: AppSizes.textSM,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 240,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double baseRadius = 30;
          final double maxRadius = 100;

          return PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 65,
                  title: '65%',
                  color: Colors.black87,
                  radius:
                      baseRadius + (maxRadius - baseRadius) * _animation.value,
                  titleStyle: const TextStyle(
                    fontSize: AppSizes.textLG,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: 20,
                  title: '20%',
                  color: const Color(0xFF1B4965),
                  radius: baseRadius +
                      (maxRadius - baseRadius) *
                          (_animation.value.clamp(0.3, 1.0)),
                  titleStyle: const TextStyle(
                    fontSize: AppSizes.textLG,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: 15,
                  title: '15%',
                  color: const Color(0xFF5FA8D3),
                  radius: baseRadius +
                      (maxRadius - baseRadius) *
                          (_animation.value.clamp(0.6, 1.0)),
                  titleStyle: const TextStyle(
                    fontSize: AppSizes.textLG,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
              sectionsSpace: 0,
              centerSpaceRadius: 0,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegendItem(String label, String percentage, Color color) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(20 * (1 - _animation.value), 0),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSM),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppSizes.textMD,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  percentage,
                  style: const TextStyle(
                    fontSize: AppSizes.textMD,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCongratulationsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.trending_up,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: AppSizes.textLG,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You managed to save 1.2% on your expenses from last month',
                  style: TextStyle(
                    fontSize: AppSizes.textSM,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String amount,
    required String percentage,
    required bool isPositive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacingLG),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppSizes.textMD,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingMD),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$$amount',
                  style: const TextStyle(
                    fontSize: AppSizes.text2XL,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSM),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.red)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${isPositive ? '+' : '-'}$percentage',
                    style: TextStyle(
                      fontSize: AppSizes.textXS,
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.black87,
            fontSize: AppSizes.textXL,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCashflowHeader(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildPieChart(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildLegendItem('Daily essentials', '65%', Colors.black87),
              const SizedBox(height: AppSizes.spacingMD),
              _buildLegendItem('Electricity', '20%', const Color(0xFF1B4965)),
              const SizedBox(height: AppSizes.spacingMD),
              _buildLegendItem('Others', '15%', const Color(0xFF5FA8D3)),
              const SizedBox(height: AppSizes.spacingXL),
              _buildCongratulationsCard(),
              const SizedBox(height: AppSizes.spacingXL),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Income',
                      amount: '41,321',
                      percentage: '2%',
                      isPositive: true,
                      onTap: () {
                        // Handle income details
                      },
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacingLG),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Expense',
                      amount: '8,847',
                      percentage: '1.5%',
                      isPositive: false,
                      onTap: () {
                        // Handle expense details
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spacingXL),
            ],
          ),
        ),
      ),
    );
  }
}
