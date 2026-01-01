class ApiPath {
  // Base Endpoints
  static const String baseUrl = 'https://darapay.io//api';

  // Common Endpoints
  static const String countriesEndpoint = '/get-countries';
  static const String getSettingsEndpoint = '/get-settings';
  static const String getUserProfileEndpoint = '/auth/agent/profile';
  static const String termsAndConditionsEndpoint = '/terms-conditions';
  static const String getSetupFcm = '/setup-fcm';
  static const String getTransactionsTypesAndStatusEndpoint =
      '/get-transaction-types-and-statuses';

  static String getConverterEndpoint({
    required String amount,
    required String currencyCode,
    bool? isThousandSeparatorRemove = true,
  }) => '/convert/$amount/$currencyCode/$isThousandSeparatorRemove';

  static String getCurrencyToCurrencyConverterEndpoint({
    required String amount,
    required String toCurrencyCode,
    bool? isThousandSeparatorRemove = true,
    required String? fromCurrencyCode,
  }) =>
      '/convert/$amount/$toCurrencyCode/$isThousandSeparatorRemove/$fromCurrencyCode';

  // Authentication Endpoints
  static const String loginEndpoint = '/auth/agent/login';
  static const String getRegisterFieldsEndpoint = '/get-register-fields/agent';
  static const String getRegisterConfigEndpoint = '/auth/agent/config';
  static const String registerEndpoint = '/auth/agent/register';
  static const String logoutEndpoint = '/auth/agent/logout';
  static const String forgotPasswordEndpoint = '/auth/agent/forgot-password';
  static const String resetVerifyOtpEndpoint = '/auth/agent/reset-verify-otp';
  static const String resetPasswordEndpoint = '/auth/agent/reset-password';
  static const String verifyEmailEndpoint = '/auth/agent/send-verify-email';
  static const String validateVerifyEmailEndpoint =
      '/auth/agent/validate-verify-email';
  static const String twoFaEndpoint = '/auth/agent/2fa/verify';
  static const String personalInfoEndpoint = '/auth/agent/personal-info-update';
  static const String kycRejectedEndpoint = '/agent/kyc/rejected-data';

  // Dashboard Endpoints
  static const String dashboardEndpoint = '/agent/dashboard';

  // Wallets Endpoints
  static const String walletsEndpoint = '/agent/wallets';
  static const String currenciesEndpoint = '/get-currencies';

  // Add Money Endpoints
  static const String getGatewayMethodsEndpoint = '/agent/add-money';
  static const String postAddMoneyEndpoint = '/agent/add-money';
  static const String addMoneyHistoryEndpoint = '/agent/transactions';

  // Cash In Endpoints
  static const String cashInConfigEndpoint = '/agent/cashin/config';
  static const String cashInEndpoint = '/agent/cashin';
  static const String cashOutHistoryEndpoint = '/agent/cashin/history';
  static const String cashInHistoryEndpoint = '/agent/cashin/history';

  // Withdraw Endpoints
  static const String withdrawAccountEndpoint = '/agent/withdraw-accounts';
  static const String withdrawEndpoint = '/agent/withdraw';
  static const String withdrawMethodsEndpoint =
      '/agent/withdraw-accounts/methods/list';
  static const String withdrawAccountCreateEndpoint =
      '/agent/withdraw-accounts';
  static const String withdrawHistoryEndpoint = '/agent/transactions';

  // Transactions Endpoints
  static const String transactionsEndpoint = '/agent/transactions';

  // Profit History Endpoints
  static const String profitHistoryEndpoint = '/agent/transactions';

  // QR Code Endpoints
  static const String qrCodeEndpoint = '/agent/qrcode';

  // Support Ticket Endpoints
  static const String supportTicketsEndpoint = '/agent/ticket';

  // Profile Settings Endpoints
  static const String updateProfileEndpoint = '/agent/settings/profile';

  // Change Password Endpoints
  static const String changePasswordEndpoint =
      '/agent/settings/change-password';

  // Notifications Endpoints
  static const String markAsReadNotificationEndpoint =
      '/mark-as-read-notification';
  static const String getNotificationsEndpoint = '/get-notifications';

  // Two Fa Authentication Endpoints
  static const String twoFaGenerateQRCodeEndpoint =
      '/agent/settings/2fa/generate';
  static const String enableTwoFaEndpoint = '/agent/settings/2fa/enable';
  static const String disableTwoFaEndpoint = '/agent/settings/2fa/disable';

  // Id Verification Endpoints
  static const String userKycEndpoint = '/agent/kyc';
  static const String kycHistoryEndpoint = '/agent/kyc/history';

  // Exchange Endpoints
  static const String exchangeConfigEndpoint = '/agent/exchange/config';
  static const String exchangeWalletEndpoint = '/agent/exchange';
  static const String exchangeHistoryEndpoint = '/agent/exchange/history';
}
