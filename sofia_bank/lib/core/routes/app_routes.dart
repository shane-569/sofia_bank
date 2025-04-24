import 'package:flutter/material.dart';
import 'package:sofia_bank/features/auth/presentation/pages/landing_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sofia_bank/features/home/presentation/pages/home_page.dart';
import 'package:sofia_bank/features/services/presentation/pages/services_page.dart';
import 'package:sofia_bank/features/cards/presentation/pages/cards_page.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loans_page.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loan_form_page.dart';
import 'package:sofia_bank/features/statistics/presentation/pages/statistics_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/';
  static const String services = '/services';
  static const String cards = '/cards';
  static const String loans = '/loans';
  static const String loanForm = '/loans/form';
  static const String statistics = '/statistics';

  static Map<String, Widget Function(BuildContext)> routes = {
    landing: (context) => const LandingPage(),
    signIn: (context) => const SignInPage(),
    signUp: (context) => const SignUpPage(),
    home: (context) => const HomePage(),
    services: (context) => const ServicesPage(),
    cards: (context) => const CardsPage(),
    loans: (context) => const LoansPage(),
    statistics: (context) => const StatisticsPage(),
    loanForm: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return LoanFormPage(
        loanType: args['loanType'],
        interestRate: args['interestRate'],
        minAmount: args['minAmount'],
        maxAmount: args['maxAmount'],
        minTenure: args['minTenure'],
        maxTenure: args['maxTenure'],
      );
    },
  };
}
