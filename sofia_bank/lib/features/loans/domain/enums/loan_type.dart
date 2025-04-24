import 'package:sofia_bank/core/constants/app_assets.dart';

enum LoanType {
  personal,
  home,
  business,
  car,
  gold,
  education;

  String get displayName {
    switch (this) {
      case LoanType.personal:
        return 'Personal Loan';
      case LoanType.home:
        return 'Home Loan';
      case LoanType.business:
        return 'Business Loan';
      case LoanType.car:
        return 'Car Loan';
      case LoanType.gold:
        return 'Gold Loan';
      case LoanType.education:
        return 'Education Loan';
    }
  }

  String get description {
    switch (this) {
      case LoanType.personal:
        return 'Quick personal loans for your needs';
      case LoanType.home:
        return 'Make your dream home a reality';
      case LoanType.business:
        return 'Grow your business with flexible loans';
      case LoanType.car:
        return 'Drive your dream car today';
      case LoanType.gold:
        return 'Get instant loans against your gold';
      case LoanType.education:
        return 'Get instant loans for education';
    }
  }

  String get icon {
    switch (this) {
      case LoanType.personal:
        return AppAssets.userAsset;
      case LoanType.home:
        return AppAssets.homeAsset;
      case LoanType.business:
        return AppAssets.businessAsset;
      case LoanType.car:
        return AppAssets.carAsset;
      case LoanType.gold:
        return AppAssets.dollarAsset;
      case LoanType.education:
        return AppAssets.dollarAsset;
    }
  }
}
