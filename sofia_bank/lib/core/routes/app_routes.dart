import 'package:flutter/material.dart';
import 'package:sofia_bank/features/auth/presentation/pages/landing_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sofia_bank/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sofia_bank/features/deposits/presentation/pages/deposits_page.dart';
import 'package:sofia_bank/features/deposits/presentation/pages/user_deposits_page.dart';
import 'package:sofia_bank/features/home/presentation/pages/home_page.dart';
import 'package:sofia_bank/features/services/presentation/pages/services_page.dart';
import 'package:sofia_bank/features/cards/presentation/pages/cards_page.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loans_page.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loan_form_page.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loan_details_page.dart';
import 'package:sofia_bank/features/statistics/presentation/pages/statistics_page.dart';
import 'package:sofia_bank/features/insurance/presentation/pages/insurance_page.dart';
import 'package:sofia_bank/features/insurance/presentation/pages/all_quick_actions_page.dart';

import '../../features/insurance/presentation/pages/health_insurance_form_page.dart';
import '../../features/insurance/presentation/pages/bike_insurance_form_page.dart';
import '../../features/insurance/presentation/pages/file_claim_form_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String services = '/services';
  static const String cards = '/cards';
  static const String loans = '/loans';
  static const String loanForm = '/loans/form';
  static const String loanDetails = '/loans/details';
  static const String statistics = '/statistics';
  static const String deposits = '/deposits';
  static const String userdeposits = '/userdeposits';
  static const String insurance = '/insurance';
  static const String allQuickActions = '/insurance/quick-actions';
  static const String healthInsuranceForm = '/healthInsuranceForm';
  static const String bikeInsuranceForm = '/bike-insurance-form';
  static const String fileClaimForm = '/file-claim';

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
    loanDetails: (context) {
      final loan = ModalRoute.of(context)!.settings.arguments as Loan;
      return LoanDetailsPage(loan: loan);
    },
    deposits: (context) => const DepositsPage(),
    userdeposits: (context) => const UserDepositsPage(),
    insurance: (context) => const InsurancePage(),
    allQuickActions: (context) => const AllQuickActionsPage(),
    healthInsuranceForm: (context) => const HealthInsuranceFormPage(),
    bikeInsuranceForm: (context) => const BikeInsuranceFormPage(),
    fileClaimForm: (context) => const FileClaimFormPage(),
  };
}
