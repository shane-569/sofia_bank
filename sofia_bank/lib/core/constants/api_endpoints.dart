class ApiEndpoints {
  static const String baseUrl = 'YOUR_BASE_URL';

  // Auth endpoints
  static const String signUp = '/auth/signup';
  static const String signIn = '/auth/signin';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // Account endpoints
  static const String accountBalance = '/account/balance';
  static const String accountTransactions = '/account/transactions';
  static const String transferMoney = '/account/transfer';

  // Other endpoints can be added here
}
