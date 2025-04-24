import 'package:flutter/material.dart';
import 'package:sofia_bank/core/navigation/app_pages.dart';
import 'package:sofia_bank/core/navigation/app_tab_bar.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/core/theme/app_dimensions.dart';
import 'package:sofia_bank/features/common/widgets/circular_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentIndex == 0 ? AppColors.primary : Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: AppPages.pages.map((page) => page.page).toList(),
        ),
      ),
      bottomNavigationBar: AppTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: CircularButton(
        elevation: 5,
        icon: Icons.qr_code,
        onPressed: () {},
        size: AppDimensions.buttonHeightMd,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
