import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/common/widgets/service_grid_item.dart';
import 'package:sofia_bank/main.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> with RouteAware {
  bool _isVisible = false;
  RouteObserver<PageRoute>? _routeObserver;

  void _navigateToCards(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cards);
  }

  void _navigateToLoans(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loans);
  }

  void _navigateToDeposits(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.deposits);
  }

  void _navigateToInsurance(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.insurance);
  }

  @override
  void initState() {
    super.initState();
    // Set the onTap callback for Cards and Loans
    _services[0]['onTap'] = () => _navigateToCards(context);
    _services[1]['onTap'] = () => _navigateToLoans(context);
    _services[2]['onTap'] = () => _navigateToDeposits(context);
    _services[3]['onTap'] = () => _navigateToInsurance(context);

    // Delay to ensure proper initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.unsubscribe(this);
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    // _routeObserver?.unsubscribe(this);
    // _routeObserver = ModalRoute.of(context)
    //     ?.navigator
    //     ?.widget
    //     .observers
    //     .whereType<RouteObserver<PageRoute>>()
    //     .firstOrNull;
    // if (_routeObserver != null) {
    //   _routeObserver!.subscribe(this, ModalRoute.of(context)! as PageRoute);
    // }
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // When returning to this page (tab)
    _resetAndStartAnimation();
  }

  void _resetAndStartAnimation() {
    setState(() {
      _isVisible = false;
    });
    // Use a shorter delay for better responsiveness
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  void _startAnimation() {
    _resetAndStartAnimation();
  }

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Cards',
      'icon': Icons.credit_card,
      'onTap': null, // Will be set in initState
      'backgroundColor': Color(0xFFFFE0E6), // Pink
      'iconColor': Color(0xFFE91E63),
    },
    {
      'title': 'Loans',
      'icon': Icons.account_balance,
      'onTap': () {},
      'backgroundColor': Color(0xFFFFF3E0), // Orange
      'iconColor': Color(0xFFFF9800),
    },
    {
      'title': 'Deposits',
      'icon': Icons.savings,
      'onTap': () {},
      'backgroundColor': Color(0xFFEDE7F6), // Purple
      'iconColor': Color(0xFF673AB7),
    },
    {
      'title': 'Insurance',
      'icon': Icons.health_and_safety,
      'onTap': () {},
      'backgroundColor': Color(0xFFE3F2FD), // Blue
      'iconColor': Color(0xFF2196F3),
    },
    {
      'title': 'NRI Services',
      'icon': Icons.public,
      'onTap': () {},
      'backgroundColor': Color(0xFFFFF9C4), // Yellow
      'iconColor': Color(0xFFFFEB3B),
    },
    {
      'title': 'Investments',
      'icon': Icons.trending_up,
      'onTap': () {},
      'backgroundColor': Color(0xFFE0F2F1), // Teal
      'iconColor': Color(0xFF009688),
    },
    {
      'title': 'Bill Pay',
      'icon': Icons.receipt_long,
      'onTap': () {},
      'backgroundColor': Color(0xFFFFEBEE), // Red
      'iconColor': Color(0xFFF44336),
    },
    {
      'title': 'Transfers',
      'icon': Icons.swap_horiz,
      'onTap': () {},
      'backgroundColor': Color(0xFFE8F5E9), // Green
      'iconColor': Color(0xFF4CAF50),
    },
    {
      'title': 'More',
      'icon': Icons.grid_view,
      'onTap': () {},
      'backgroundColor': Color(0xFFF3E5F5), // Lavender
      'iconColor': Color(0xFF9C27B0),
    },
  ];

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              AppAssets.bigBubble,
              width: 100,
              height: 80,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              AppAssets.mockCard,
              width: 100,
              height: 80,
              colorFilter: ColorFilter.mode(
                AppColors.primary.withOpacity(0.5),
                BlendMode.srcIn,
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Services',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Explore our range of banking services',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.primary,
        systemNavigationBarColor: AppColors.primary,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Container(
              color: AppColors.background,
              child: SafeArea(
                bottom: false,
                child: _buildHeader(),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  // Calculate row and column for blooming effect
                  final int row = index ~/ 3;
                  final int col = index % 3;
                  return ServiceGridItem(
                    title: service['title'],
                    icon: service['icon'],
                    onTap: service['onTap'],
                    index: index,
                    backgroundColor: service['backgroundColor'],
                    iconColor: service['iconColor'],
                    isVisible: _isVisible,
                    row: row,
                    col: col,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
