import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class PerformanceChart extends StatefulWidget {
  const PerformanceChart({Key? key}) : super(key: key);

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 20,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: AppColors.textSecondary.withOpacity(0.1),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            );
                            String text;
                            switch (value.toInt()) {
                              case 0:
                                text = 'Jan';
                                break;
                              case 1:
                                text = 'Feb';
                                break;
                              case 2:
                                text = 'Mar';
                                break;
                              case 3:
                                text = 'Apr';
                                break;
                              case 4:
                                text = 'May';
                                break;
                              case 5:
                                text = 'Jun';
                                break;
                              default:
                                text = '';
                            }
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(text, style: style),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text('${value.toInt()}%', style: style),
                            );
                          },
                          reservedSize: 42,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 20),
                          const FlSpot(1, 35),
                          const FlSpot(2, 45),
                          const FlSpot(3, 60),
                          const FlSpot(4, 75),
                          const FlSpot(5, 85),
                        ],
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.5),
                            AppColors.primary,
                          ],
                        ),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.primary,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary.withOpacity(0.3),
                              AppColors.primary.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
