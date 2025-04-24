import 'package:flutter/material.dart';
import 'package:sofia_bank/features/home/presentation/pages/home_content.dart';
import 'package:sofia_bank/features/services/presentation/pages/services_page.dart';
import 'package:sofia_bank/features/settings/presentation/pages/settings_page.dart';

class AppPage {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final Widget page;

  const AppPage({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}

class AppPages {
  static const List<AppPage> pages = [
    AppPage(
      title: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      page: HomeContent(),
    ),
    AppPage(
      title: 'Search',
      icon: Icons.search_outlined,
      activeIcon: Icons.search_rounded,
      page: ServicesPage(), // TODO: Replace with actual search page
    ),
    AppPage(
      title: 'Messages',
      icon: Icons.mail_outline_rounded,
      activeIcon: Icons.mail_rounded,
      page: Center(
          child: Text('Messages')), // TODO: Replace with actual messages page
    ),
    AppPage(
      title: 'Settings',
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      page: SettingsPage(),
    ),
  ];
}
