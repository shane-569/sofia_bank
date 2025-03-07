import 'package:flutter/material.dart';
import 'package:sofia_bank/features/auth/presentation/pages/landing_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_up_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> get routes => {
        landing: (context) => const LandingPage(),
        signin: (context) => const SignInPage(),
        signup: (context) => const SignUpPage(),
      };
}
