import 'package:get/get.dart';
import 'package:qunzo_agent/src/app/bindings/app_bindings.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/app/routes/routes_config.dart';

List<GetPage> routesHandler = [
  GetPage(
    name: BaseRoute.splash,
    page: () => RoutesConfig.splash,
    binding: SplashBinding(),
  ),

  GetPage(name: BaseRoute.welcome, page: () => RoutesConfig.welcome),

  GetPage(
    name: BaseRoute.signIn,
    page: () => RoutesConfig.signIn,
    bindings: [SignInBinding(), UserProfileBinding()],
  ),

  GetPage(
    name: BaseRoute.verifyEmail,
    page: () => RoutesConfig.verifyEmail,
    binding: VerifyEmailBinding(),
  ),

  GetPage(
    name: BaseRoute.twoFactorAuth,
    page: () => RoutesConfig.twoFactorAuth,
    binding: TwoFactorAuthBinding(),
  ),

  GetPage(
    name: BaseRoute.forgotPassword,
    page: () => RoutesConfig.forgotPassword,
    binding: ForgotPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.forgotPasswordPinVerification,
    page: () => RoutesConfig.forgotPasswordPinVerification,
    binding: ForgotPasswordPinVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.signUpStatus,
    page: () => RoutesConfig.signUpStatus,
    binding: SignUpStatusBinding(),
  ),

  GetPage(
    name: BaseRoute.personalInfo,
    page: () => RoutesConfig.personalInfo,
    bindings: [
      PersonalInfoBinding(),
      RegisterFieldsBinding(),
      CountryBinding(),
    ],
  ),

  GetPage(
    name: BaseRoute.authIdVerification,
    page: () => RoutesConfig.authIdVerification,
    binding: AuthIdVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.setUpPassword,
    page: () => RoutesConfig.setUpPassword,
    binding: SetUpPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.resetPassword,
    page: () => RoutesConfig.resetPassword,
    binding: ResetPasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.email,
    page: () => RoutesConfig.email,
    binding: EmailBinding(),
  ),

  GetPage(
    name: BaseRoute.navigation,
    page: () => RoutesConfig.navigation,
    bindings: [
      HomeBinding(),
      UserProfileBinding(),
      TransactionsBinding(),
      WalletsBinding(),
    ],
  ),

  GetPage(
    name: BaseRoute.createNewWallet,
    page: () => RoutesConfig.createNewWallet,
    binding: CreateNewWalletBinding(),
  ),

  GetPage(
    name: BaseRoute.transactions,
    page: () => RoutesConfig.transactions,
    binding: TransactionsBinding(),
  ),

  GetPage(
    name: BaseRoute.cashIn,
    page: () => RoutesConfig.cashIn,
    binding: CashInBinding(),
  ),

  GetPage(
    name: BaseRoute.addMoney,
    page: () => RoutesConfig.addMoney,
    binding: AddMoneyBinding(),
  ),

  GetPage(
    name: BaseRoute.withdraw,
    page: () => RoutesConfig.withdraw,
    bindings: [WithdrawBinding(), WithdrawAccountBinding()],
  ),

  GetPage(
    name: BaseRoute.createWithdrawAccount,
    page: () => RoutesConfig.createWithdrawAccount,
    binding: CreateWithdrawAccountBinding(),
  ),

  GetPage(
    name: BaseRoute.notification,
    page: () => RoutesConfig.notification,
    binding: NotificationBinding(),
  ),

  GetPage(
    name: BaseRoute.qrCode,
    page: () => RoutesConfig.qrCode,
    binding: QrCodeBinding(),
  ),

  GetPage(
    name: BaseRoute.support,
    page: () => RoutesConfig.support,
    binding: SupportTicketBinding(),
  ),

  GetPage(
    name: BaseRoute.addNewTicket,
    page: () => RoutesConfig.addNewTicket,
    binding: AddNewTicketBinding(),
  ),

  GetPage(name: BaseRoute.settings, page: () => RoutesConfig.settings),

  GetPage(
    name: BaseRoute.profileSettings,
    page: () => RoutesConfig.profileSettings,
    binding: ProfileSettingsBinding(),
  ),

  GetPage(
    name: BaseRoute.changePassword,
    page: () => RoutesConfig.changePassword,
    binding: ChangePasswordBinding(),
  ),

  GetPage(
    name: BaseRoute.wallets,
    page: () => RoutesConfig.wallets,
    binding: WalletsBinding(),
  ),

  GetPage(
    name: BaseRoute.twoFaAuthentication,
    page: () => RoutesConfig.twoFaAuthentication,
    bindings: [TwoFaAuthenticationBinding(), UserProfileBinding()],
  ),

  GetPage(
    name: BaseRoute.walletsDetails,
    page: () => RoutesConfig.walletsDetails,
    binding: WalletDetailsBinding(),
  ),

  GetPage(
    name: BaseRoute.idVerification,
    page: () => RoutesConfig.idVerification,
    binding: IdVerificationBinding(),
  ),

  GetPage(
    name: BaseRoute.kycHistory,
    page: () => RoutesConfig.kycHistory,
    binding: KycHistoryBinding(),
  ),

  GetPage(
    name: BaseRoute.profitHistory,
    page: () => RoutesConfig.profitHistory,
    binding: ProfitHistoryBinding(),
  ),

  GetPage(
    name: BaseRoute.noInternetConnection,
    page: () => RoutesConfig.noInternetConnection,
  ),

  GetPage(
    name: BaseRoute.exchange,
    page: () => RoutesConfig.exchange,
    binding: ExchangeBinding(),
  ),
];
