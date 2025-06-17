import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({Key? key}) : super(key: key);

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInvestmentOption({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180,
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: iconColor,
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Investment Options',
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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInvestmentOption(
                      title: 'Crypto',
                      icon: Icons.currency_bitcoin,
                      backgroundColor: const Color(0xFFFFF3E0),
                      iconColor: const Color(0xFFFF9800),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.cryptoTrading);
                      },
                    ),
                    _buildInvestmentOption(
                      title: 'Mutual Funds',
                      icon: Icons.trending_up,
                      backgroundColor: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF4CAF50),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.mutualFunds);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Investment are subjected to market risks, Please read the investment realated documents carefully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
