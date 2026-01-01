import 'package:get/get.dart';
import 'package:qunzo_agent/src/common/controller/country_controller.dart';
import 'package:qunzo_agent/src/common/controller/register_fields_controller.dart';
import 'package:qunzo_agent/src/common/controller/status_controller.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/forgot_password/controller/forgot_password_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/forgot_password/controller/forgot_password_pin_verification_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/forgot_password/controller/reset_password_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/auth_id_verification_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/email_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/personal_info_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/set_up_password_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/sign_up_status_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/verify_email_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/splash/controller/splash_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/two_factor_auth/controller/two_factor_auth_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/controller/cash_in_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/id_verification/controller/id_verification_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/id_verification/controller/kyc_history_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/notification/controller/notification_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/profit_history/controller/profit_history_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/qr_code/controller/qr_code_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/change_password_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/profile_settings_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/two_fa_authentication_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/support/controller/add_new_ticket_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/support/controller/support_ticket_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/controller/transactions_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/create_new_wallet_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/wallet_details_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/wallets_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/create_withdraw_account_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

class ForgotPasswordPinVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordPinVerificationController>(
      () => ForgotPasswordPinVerificationController(),
    );
  }
}

class PersonalInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfoController>(() => PersonalInfoController());
  }
}

class RegisterFieldsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterFieldsController>(() => RegisterFieldsController());
  }
}

class SignUpStatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpStatusController>(() => SignUpStatusController());
  }
}

class SetUpPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUpPasswordController>(() => SetUpPasswordController());
  }
}

class VerifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
  }
}

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class CountryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountryController>(() => CountryController());
  }
}

class EmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailController>(() => EmailController());
  }
}

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}

class TwoFactorAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TwoFactorAuthController>(() => TwoFactorAuthController());
  }
}

class WalletsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletsController>(() => WalletsController());
  }
}

class CreateNewWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewWalletController>(() => CreateNewWalletController());
  }
}

class AddMoneyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMoneyController>(() => AddMoneyController());
  }
}

class StatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusController>(() => StatusController());
  }
}

class CashInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashInController>(() => CashInController());
  }
}

class WithdrawBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(() => WithdrawController());
  }
}

class WithdrawAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawAccountController>(() => WithdrawAccountController());
  }
}

class CreateWithdrawAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWithdrawAccountController>(
      () => CreateWithdrawAccountController(),
    );
  }
}

class TransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}

class QrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeController>(() => QrCodeController());
  }
}

class SupportTicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportTicketController>(() => SupportTicketController());
  }
}

class AddNewTicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewTicketController>(() => AddNewTicketController());
  }
}

class ProfileSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsController>(() => ProfileSettingsController());
  }
}

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}

class TwoFaAuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TwoFaAuthenticationController>(
      () => TwoFaAuthenticationController(),
    );
  }
}

class WalletDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletDetailsController>(() => WalletDetailsController());
  }
}

class AuthIdVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthIdVerificationController>(
      () => AuthIdVerificationController(),
    );
  }
}

class IdVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdVerificationController>(() => IdVerificationController());
  }
}

class KycHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycHistoryController>(() => KycHistoryController());
  }
}

class ProfitHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfitHistoryController>(() => ProfitHistoryController());
  }
}

class ExchangeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController());
  }
}
