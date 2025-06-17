import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/investment/presentation/bloc/mutual_funds_bloc.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/mutual_fund_card.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/performance_chart.dart';
import 'package:sofia_bank/features/investment/presentation/widgets/investment_summary.dart';

class MutualFundsPage extends StatefulWidget {
  const MutualFundsPage({Key? key}) : super(key: key);

  @override
  State<MutualFundsPage> createState() => _MutualFundsPageState();
}

class _MutualFundsPageState extends State<MutualFundsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  int _selectedIndex = 0;
  final List<String> _categories = ['All', 'Equity', 'Debt', 'Hybrid'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
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
    return BlocBuilder<MutualFundsBloc, MutualFundsState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Mutual Funds',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back_ios, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: const InvestmentSummary(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ChoiceChip(
                                  label: Text(_categories[index]),
                                  selected: _selectedIndex == index,
                                  onSelected: (selected) {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    context.read<MutualFundsBloc>().add(
                                          FilterMutualFunds(_categories[index]),
                                        );
                                  },
                                  backgroundColor: Colors.white,
                                  selectedColor:
                                      AppColors.primary.withOpacity(0.2),
                                  labelStyle: TextStyle(
                                    color: _selectedIndex == index
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: const PerformanceChart(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Popular Funds',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle explore more action
                            },
                            child: const Text(
                              'Explore More',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  itemCount: state.mutualFunds.length,
                                  itemBuilder: (context, index) {
                                    return MutualFundCard(
                                      mutualFund: state.mutualFunds[index],
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
