import 'package:flutter/material.dart';
import 'package:sofia_bank/features/auth/presentation/pages/landing_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sofia_bank/features/home/presentation/pages/home_page.dart';
import 'package:sofia_bank/features/services/presentation/pages/services_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String services = '/services';

  static Map<String, Widget Function(BuildContext)> routes = {
    landing: (context) => const LandingPage(),
    signIn: (context) => const SignInPage(),
    signUp: (context) => const SignUpPage(),
    home: (context) => const HomePage(),
    services: (context) => const ServicesPage(),
  };
}
