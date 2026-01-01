import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @comment_common_alert_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Common Alert Bottom Sheet ===='**
  String get comment_common_alert_bottom_sheet;

  /// No description provided for @commonAlertConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonAlertConfirmButton;

  /// No description provided for @commonAlertCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonAlertCancelButton;

  /// No description provided for @comment_common_alert.
  ///
  /// In en, this message translates to:
  /// **'==== Common Alert ===='**
  String get comment_common_alert;

  /// No description provided for @commonAlertExitTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Application'**
  String get commonAlertExitTitle;

  /// No description provided for @commonAlertExitMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the application?'**
  String get commonAlertExitMessage;

  /// No description provided for @comment_image_picker_dropdown_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Image Picker Dropdown Bottom Sheet ===='**
  String get comment_image_picker_dropdown_bottom_sheet;

  /// No description provided for @imagePickerDropdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get imagePickerDropdownTitle;

  /// No description provided for @imagePickerDropdownCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get imagePickerDropdownCamera;

  /// No description provided for @imagePickerDropdownGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get imagePickerDropdownGallery;

  /// No description provided for @comment_common_country_dropdown.
  ///
  /// In en, this message translates to:
  /// **'==== Common Country Dropdown ===='**
  String get comment_common_country_dropdown;

  /// No description provided for @countryDropdownSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get countryDropdownSearchHint;

  /// No description provided for @countryDropdownNotFound.
  ///
  /// In en, this message translates to:
  /// **'Country not found'**
  String get countryDropdownNotFound;

  /// No description provided for @comment_all_controller.
  ///
  /// In en, this message translates to:
  /// **'==== All Controller ===='**
  String get comment_all_controller;

  /// No description provided for @allControllerLoadError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get allControllerLoadError;

  /// No description provided for @comment_splash_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Splash Screen ===='**
  String get comment_splash_screen;

  /// No description provided for @splashAgentBadge.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get splashAgentBadge;

  /// No description provided for @comment_agent_navigation_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Agent Navigation Screen ===='**
  String get comment_agent_navigation_screen;

  /// No description provided for @agentNavigationBottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get agentNavigationBottomNavHome;

  /// No description provided for @agentNavigationBottomNavWallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get agentNavigationBottomNavWallets;

  /// No description provided for @agentNavigationBottomNavTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get agentNavigationBottomNavTransactions;

  /// No description provided for @agentNavigationBottomNavSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get agentNavigationBottomNavSettings;

  /// No description provided for @agentNavigationQrInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR code. Must be digits only or in UID format.'**
  String get agentNavigationQrInvalidFormat;

  /// No description provided for @comment_image_picker_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Image Picker Controller ===='**
  String get comment_image_picker_controller;

  /// No description provided for @imagePickerGalleryError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image from gallery'**
  String get imagePickerGalleryError;

  /// No description provided for @imagePickerCameraError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image from camera'**
  String get imagePickerCameraError;

  /// No description provided for @comment_biometric_auth_service.
  ///
  /// In en, this message translates to:
  /// **'==== Biometric Auth Service ===='**
  String get comment_biometric_auth_service;

  /// No description provided for @biometricDeviceNotSupported.
  ///
  /// In en, this message translates to:
  /// **'This device does not support biometrics.'**
  String get biometricDeviceNotSupported;

  /// No description provided for @biometricNotEnrolled.
  ///
  /// In en, this message translates to:
  /// **'No biometric enrolled. Please set up fingerprint'**
  String get biometricNotEnrolled;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric features are currently unavailable.'**
  String get biometricUnavailable;

  /// No description provided for @biometricAuthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed.'**
  String get biometricAuthenticationFailed;

  /// No description provided for @biometricCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to check biometric availability.'**
  String get biometricCheckFailed;

  /// No description provided for @biometricAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to log in'**
  String get biometricAuthReason;

  /// No description provided for @comment_network_service.
  ///
  /// In en, this message translates to:
  /// **'==== Network Service ===='**
  String get comment_network_service;

  /// No description provided for @networkErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get networkErrorGeneric;

  /// No description provided for @networkErrorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get networkErrorTimeout;

  /// No description provided for @networkErrorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get networkErrorNoInternet;

  /// No description provided for @networkErrorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this resource. Please log in again!'**
  String get networkErrorUnauthorized;

  /// No description provided for @networkErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get networkErrorOccurred;

  /// No description provided for @unauthorizedDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get unauthorizedDialogTitle;

  /// No description provided for @unauthorizedDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this resource. Please log in again!'**
  String get unauthorizedDialogDescription;

  /// No description provided for @unauthorizedDialogButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get unauthorizedDialogButton;

  /// No description provided for @comment_add_money_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Controller ===='**
  String get comment_add_money_controller;

  /// No description provided for @addMoneySuccess.
  ///
  /// In en, this message translates to:
  /// **'Money added successfully'**
  String get addMoneySuccess;

  /// No description provided for @validationSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Please select a wallet'**
  String get validationSelectWallet;

  /// No description provided for @validationSelectGateway.
  ///
  /// In en, this message translates to:
  /// **'Please select a gateway'**
  String get validationSelectGateway;

  /// No description provided for @validationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get validationEnterAmount;

  /// No description provided for @validationAmountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0'**
  String get validationAmountGreaterThanZero;

  /// No description provided for @validationAmountMinimumDeposit.
  ///
  /// In en, this message translates to:
  /// **'Minimum deposit amount is {amount}'**
  String validationAmountMinimumDeposit(Object amount);

  /// No description provided for @validationAmountMaximumDeposit.
  ///
  /// In en, this message translates to:
  /// **'Maximum deposit amount is {amount}'**
  String validationAmountMaximumDeposit(Object amount);

  /// No description provided for @validationUploadFile.
  ///
  /// In en, this message translates to:
  /// **'Please upload a file for {fieldName}'**
  String validationUploadFile(Object fieldName);

  /// No description provided for @validationFillField.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the {fieldName} field'**
  String validationFillField(Object fieldName);

  /// No description provided for @comment_add_money_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Screen ===='**
  String get comment_add_money_screen;

  /// No description provided for @addMoneyScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get addMoneyScreenTitle;

  /// No description provided for @comment_add_money_amount_section.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Amount Section ===='**
  String get comment_add_money_amount_section;

  /// No description provided for @addMoneySelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get addMoneySelectWallet;

  /// No description provided for @addMoneySelectGateway.
  ///
  /// In en, this message translates to:
  /// **'Select Gateway'**
  String get addMoneySelectGateway;

  /// No description provided for @addMoneyEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addMoneyEnterAmount;

  /// No description provided for @addMoneyAmountRange.
  ///
  /// In en, this message translates to:
  /// **'Minimum {minAmount} {currency} and Maximum {maxAmount} {currency}'**
  String addMoneyAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  );

  /// No description provided for @addMoneyContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get addMoneyContinueButton;

  /// No description provided for @addMoneyDropdownWalletNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet not found'**
  String get addMoneyDropdownWalletNotFound;

  /// No description provided for @addMoneyDropdownGatewayNotFound.
  ///
  /// In en, this message translates to:
  /// **'Gateway not found'**
  String get addMoneyDropdownGatewayNotFound;

  /// No description provided for @addMoneyDropdownSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get addMoneyDropdownSelectWallet;

  /// No description provided for @addMoneyDropdownSelectGateway.
  ///
  /// In en, this message translates to:
  /// **'Select Gateway'**
  String get addMoneyDropdownSelectGateway;

  /// No description provided for @comment_add_money_pending_section.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Pending Section ===='**
  String get comment_add_money_pending_section;

  /// No description provided for @addMoneyPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Deposit Process is Pending'**
  String get addMoneyPendingTitle;

  /// No description provided for @addMoneyPendingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your funds have been successfully add money.'**
  String get addMoneyPendingDescription;

  /// No description provided for @addMoneyAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addMoneyAmount;

  /// No description provided for @addMoneyTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get addMoneyTransactionId;

  /// No description provided for @addMoneyWalletName.
  ///
  /// In en, this message translates to:
  /// **'Wallet Name'**
  String get addMoneyWalletName;

  /// No description provided for @addMoneyPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get addMoneyPaymentMethod;

  /// No description provided for @addMoneyCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get addMoneyCharge;

  /// No description provided for @addMoneyType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get addMoneyType;

  /// No description provided for @addMoneyFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get addMoneyFinalAmount;

  /// No description provided for @addMoneyBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get addMoneyBackHome;

  /// No description provided for @addMoneyAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get addMoneyAgain;

  /// No description provided for @comment_add_money_review_section.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Review Section ===='**
  String get comment_add_money_review_section;

  /// No description provided for @addMoneyReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Details'**
  String get addMoneyReviewTitle;

  /// No description provided for @addMoneyReviewAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addMoneyReviewAmount;

  /// No description provided for @addMoneyReviewWalletName.
  ///
  /// In en, this message translates to:
  /// **'Wallet Name'**
  String get addMoneyReviewWalletName;

  /// No description provided for @addMoneyReviewPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get addMoneyReviewPaymentMethod;

  /// No description provided for @addMoneyReviewCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get addMoneyReviewCharge;

  /// No description provided for @addMoneyReviewTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get addMoneyReviewTotal;

  /// No description provided for @addMoneyReviewAddMoneyButton.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get addMoneyReviewAddMoneyButton;

  /// No description provided for @comment_add_money_success_section.
  ///
  /// In en, this message translates to:
  /// **'==== Add Money Success Section ===='**
  String get comment_add_money_success_section;

  /// No description provided for @addMoneySuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit Money Successful'**
  String get addMoneySuccessTitle;

  /// No description provided for @addMoneySuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your funds have been successfully deposit.'**
  String get addMoneySuccessDescription;

  /// No description provided for @addMoneySuccessAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addMoneySuccessAmount;

  /// No description provided for @addMoneySuccessTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get addMoneySuccessTransactionId;

  /// No description provided for @addMoneySuccessCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get addMoneySuccessCharge;

  /// No description provided for @addMoneySuccessType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get addMoneySuccessType;

  /// No description provided for @addMoneySuccessFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get addMoneySuccessFinalAmount;

  /// No description provided for @addMoneySuccessBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get addMoneySuccessBackHome;

  /// No description provided for @addMoneySuccessAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get addMoneySuccessAgain;

  /// No description provided for @comment_forgot_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Forgot Password Screen ===='**
  String get comment_forgot_password_screen;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get forgotPasswordEmailHint;

  /// No description provided for @forgotPasswordSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Link'**
  String get forgotPasswordSendButton;

  /// No description provided for @forgotPasswordBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get forgotPasswordBackButton;

  /// No description provided for @forgotPasswordEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'The email field is required'**
  String get forgotPasswordEmailRequired;

  /// No description provided for @comment_forgot_password_pin_verification.
  ///
  /// In en, this message translates to:
  /// **'==== Forgot Password Pin Verification ===='**
  String get comment_forgot_password_pin_verification;

  /// No description provided for @forgotPasswordPinVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get forgotPasswordPinVerifyTitle;

  /// No description provided for @forgotPasswordPinVerifyOtpSent.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to '**
  String get forgotPasswordPinVerifyOtpSent;

  /// No description provided for @forgotPasswordPinVerifyCountdown.
  ///
  /// In en, this message translates to:
  /// **'OTP in {seconds}s'**
  String forgotPasswordPinVerifyCountdown(Object seconds);

  /// No description provided for @forgotPasswordPinVerifyContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get forgotPasswordPinVerifyContinue;

  /// No description provided for @forgotPasswordPinVerifyBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get forgotPasswordPinVerifyBack;

  /// No description provided for @forgotPasswordPinRequired.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get forgotPasswordPinRequired;

  /// No description provided for @comment_reset_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Reset Password Screen ===='**
  String get comment_reset_password_screen;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get resetPasswordHint;

  /// No description provided for @resetPasswordConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get resetPasswordConfirmHint;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPasswordButton;

  /// No description provided for @resetPasswordBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get resetPasswordBackButton;

  /// No description provided for @resetPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get resetPasswordRequired;

  /// No description provided for @resetPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get resetPasswordMinLength;

  /// No description provided for @resetPasswordConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get resetPasswordConfirmRequired;

  /// No description provided for @resetPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get resetPasswordMismatch;

  /// No description provided for @comment_sign_in_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Sign In Controller ===='**
  String get comment_sign_in_controller;

  /// No description provided for @signInEmailPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email and password cannot be empty.'**
  String get signInEmailPasswordEmpty;

  /// No description provided for @signInEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get signInEmailRequired;

  /// No description provided for @comment_sign_in_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Sign In Screen ===='**
  String get comment_sign_in_screen;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent Login!'**
  String get signInTitle;

  /// No description provided for @signInEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmailHint;

  /// No description provided for @signInPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPasswordHint;

  /// No description provided for @signInForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get signInForgotPassword;

  /// No description provided for @signInLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get signInLoginButton;

  /// No description provided for @signInNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get signInNoAccount;

  /// No description provided for @signInCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get signInCreateAccount;

  /// No description provided for @signInBiometricPrompt.
  ///
  /// In en, this message translates to:
  /// **'First Sign In with Email and Password'**
  String get signInBiometricPrompt;

  /// No description provided for @signInBiometricNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Your biometric is not enabled'**
  String get signInBiometricNotEnabled;

  /// No description provided for @signInEmailFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'The email field is required'**
  String get signInEmailFieldRequired;

  /// No description provided for @signInPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'The password field is required'**
  String get signInPasswordRequired;

  /// No description provided for @comment_auth_id_verification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Auth ID Verification Screen ===='**
  String get comment_auth_id_verification_screen;

  /// No description provided for @authIdVerificationInvalidField.
  ///
  /// In en, this message translates to:
  /// **'Invalid field type'**
  String get authIdVerificationInvalidField;

  /// No description provided for @authIdVerificationUnknownField.
  ///
  /// In en, this message translates to:
  /// **'Unknown field type: {fieldType}'**
  String authIdVerificationUnknownField(Object fieldType);

  /// No description provided for @comment_file_type_section.
  ///
  /// In en, this message translates to:
  /// **'==== File Type Section ===='**
  String get comment_file_type_section;

  /// No description provided for @fileTypeChooseFileButton.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get fileTypeChooseFileButton;

  /// No description provided for @comment_kyc_submission_section.
  ///
  /// In en, this message translates to:
  /// **'==== KYC Submission Section ===='**
  String get comment_kyc_submission_section;

  /// No description provided for @kycSubmissionTitle.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get kycSubmissionTitle;

  /// No description provided for @kycSubmissionSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get kycSubmissionSubmitButton;

  /// No description provided for @kycSubmissionNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get kycSubmissionNextButton;

  /// No description provided for @kycSubmissionReUploadButton.
  ///
  /// In en, this message translates to:
  /// **'Re Upload'**
  String get kycSubmissionReUploadButton;

  /// No description provided for @kycSubmissionRetakeButton.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get kycSubmissionRetakeButton;

  /// No description provided for @comment_submit_valid_id_verification.
  ///
  /// In en, this message translates to:
  /// **'==== Submit Valid ID Verification ===='**
  String get comment_submit_valid_id_verification;

  /// No description provided for @submitValidIdVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit a Valid ID for Verification'**
  String get submitValidIdVerificationTitle;

  /// No description provided for @submitValidIdVerificationChooseIdType.
  ///
  /// In en, this message translates to:
  /// **'Choose ID Type'**
  String get submitValidIdVerificationChooseIdType;

  /// No description provided for @comment_email_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Email Screen ===='**
  String get comment_email_screen;

  /// No description provided for @emailScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent Register!'**
  String get emailScreenTitle;

  /// No description provided for @emailScreenEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailScreenEmailLabel;

  /// No description provided for @emailScreenContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get emailScreenContinueButton;

  /// No description provided for @emailScreenBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get emailScreenBackButton;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email'**
  String get emailRequired;

  /// No description provided for @comment_personal_info_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Personal Info Screen ===='**
  String get comment_personal_info_screen;

  /// No description provided for @personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent Register!'**
  String get personalInfoTitle;

  /// No description provided for @personalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfoSubtitle;

  /// No description provided for @personalInfoFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get personalInfoFirstName;

  /// No description provided for @personalInfoLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get personalInfoLastName;

  /// No description provided for @personalInfoUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get personalInfoUsername;

  /// No description provided for @personalInfoSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get personalInfoSelectCountry;

  /// No description provided for @personalInfoPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get personalInfoPhone;

  /// No description provided for @personalInfoSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get personalInfoSelectGender;

  /// No description provided for @personalInfoSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get personalInfoSubmitButton;

  /// No description provided for @personalInfoBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get personalInfoBackButton;

  /// No description provided for @personalInfoDropdownSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get personalInfoDropdownSelectCountry;

  /// No description provided for @personalInfoDropdownSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get personalInfoDropdownSelectGender;

  /// No description provided for @personalInfoDropdownGenderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Gender not found'**
  String get personalInfoDropdownGenderNotFound;

  /// No description provided for @personalInfoFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get personalInfoFirstNameRequired;

  /// No description provided for @personalInfoLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get personalInfoLastNameRequired;

  /// No description provided for @personalInfoUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get personalInfoUsernameRequired;

  /// No description provided for @personalInfoCountryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get personalInfoCountryRequired;

  /// No description provided for @personalInfoPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get personalInfoPhoneRequired;

  /// No description provided for @personalInfoGenderRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get personalInfoGenderRequired;

  /// No description provided for @comment_set_up_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Set Up Password Screen ===='**
  String get comment_set_up_password_screen;

  /// No description provided for @setUpPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get setUpPasswordTitle;

  /// No description provided for @setUpPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get setUpPasswordLabel;

  /// No description provided for @setUpPasswordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get setUpPasswordConfirmLabel;

  /// No description provided for @setUpPasswordAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree with the '**
  String get setUpPasswordAgreeTerms;

  /// No description provided for @setUpPasswordTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get setUpPasswordTermsConditions;

  /// No description provided for @setUpPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get setUpPasswordButton;

  /// No description provided for @setUpPasswordBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get setUpPasswordBackButton;

  /// No description provided for @setUpPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get setUpPasswordRequired;

  /// No description provided for @setUpPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get setUpPasswordMinLength;

  /// No description provided for @setUpPasswordConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get setUpPasswordConfirmRequired;

  /// No description provided for @setUpPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get setUpPasswordMismatch;

  /// No description provided for @setUpPasswordAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and conditions'**
  String get setUpPasswordAcceptTerms;

  /// No description provided for @comment_sign_up_status_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Sign Up Status Screen ===='**
  String get comment_sign_up_status_screen;

  /// No description provided for @signUpStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent Register!'**
  String get signUpStatusTitle;

  /// No description provided for @signUpStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Set up Your Agent Profile in a few Steps.'**
  String get signUpStatusSubtitle;

  /// No description provided for @signUpStatusEmailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get signUpStatusEmailVerification;

  /// No description provided for @signUpStatusSetupPassword.
  ///
  /// In en, this message translates to:
  /// **'Setup Password'**
  String get signUpStatusSetupPassword;

  /// No description provided for @signUpStatusPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get signUpStatusPersonalInfo;

  /// No description provided for @signUpStatusIdVerification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get signUpStatusIdVerification;

  /// No description provided for @signUpStatusInReview.
  ///
  /// In en, this message translates to:
  /// **'In Review'**
  String get signUpStatusInReview;

  /// No description provided for @signUpStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get signUpStatusRejected;

  /// No description provided for @signUpStatusNoReason.
  ///
  /// In en, this message translates to:
  /// **'No reason provided'**
  String get signUpStatusNoReason;

  /// No description provided for @signUpStatusNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get signUpStatusNextButton;

  /// No description provided for @signUpStatusSubmitAgain.
  ///
  /// In en, this message translates to:
  /// **'Submit Again'**
  String get signUpStatusSubmitAgain;

  /// No description provided for @signUpStatusDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get signUpStatusDashboard;

  /// No description provided for @signUpStatusBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get signUpStatusBackButton;

  /// No description provided for @signUpStatusErrorProcessing.
  ///
  /// In en, this message translates to:
  /// **'Error processing next step. Please try again.'**
  String get signUpStatusErrorProcessing;

  /// No description provided for @comment_verify_email_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Verify Email Screen ===='**
  String get comment_verify_email_screen;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailOtpSent.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to '**
  String get verifyEmailOtpSent;

  /// No description provided for @verifyEmailResendCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend available in {seconds}s'**
  String verifyEmailResendCountdown(Object seconds);

  /// No description provided for @verifyEmailResendReady.
  ///
  /// In en, this message translates to:
  /// **'You can request a new OTP now'**
  String get verifyEmailResendReady;

  /// No description provided for @verifyEmailContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get verifyEmailContinueButton;

  /// No description provided for @verifyEmailBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get verifyEmailBackButton;

  /// No description provided for @verifyEmailDidntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code? '**
  String get verifyEmailDidntReceive;

  /// No description provided for @verifyEmailResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get verifyEmailResend;

  /// No description provided for @verifyEmailOtpRequired.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get verifyEmailOtpRequired;

  /// No description provided for @comment_two_factor_auth_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Two Factor Auth Screen ===='**
  String get comment_two_factor_auth_screen;

  /// No description provided for @twoFactorAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Two Fa'**
  String get twoFactorAuthTitle;

  /// No description provided for @twoFactorAuthVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get twoFactorAuthVerifyButton;

  /// No description provided for @twoFactorAuthBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get twoFactorAuthBackButton;

  /// No description provided for @twoFactorAuthOtpRequired.
  ///
  /// In en, this message translates to:
  /// **'The otp field is required'**
  String get twoFactorAuthOtpRequired;

  /// No description provided for @comment_welcome_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Welcome Screen ===='**
  String get comment_welcome_screen;

  /// No description provided for @welcomeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Agent'**
  String get welcomeScreenTitle;

  /// No description provided for @welcomeScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Your dashboard is ready. Track clients, manage finances, and grow'**
  String get welcomeScreenDescription;

  /// No description provided for @welcomeScreenCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get welcomeScreenCreateAccount;

  /// No description provided for @welcomeScreenLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get welcomeScreenLogin;

  /// No description provided for @comment_cash_in_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Cash In Controller ===='**
  String get comment_cash_in_controller;

  /// No description provided for @cashInValidationEnterUserUid.
  ///
  /// In en, this message translates to:
  /// **'Please enter an User UID'**
  String get cashInValidationEnterUserUid;

  /// No description provided for @cashInValidationSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Please select a wallet'**
  String get cashInValidationSelectWallet;

  /// No description provided for @cashInValidationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get cashInValidationEnterAmount;

  /// No description provided for @cashInValidationAmountMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount should be {amount} {currency}'**
  String cashInValidationAmountMinimum(Object amount, Object currency);

  /// No description provided for @cashInValidationAmountMaximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount should be {amount} {currency}'**
  String cashInValidationAmountMaximum(Object amount, Object currency);

  /// No description provided for @comment_cash_in_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Cash In Screen ===='**
  String get comment_cash_in_screen;

  /// No description provided for @cashInScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get cashInScreenTitle;

  /// No description provided for @comment_cash_in_amount_section.
  ///
  /// In en, this message translates to:
  /// **'==== Cash In Amount Section ===='**
  String get comment_cash_in_amount_section;

  /// No description provided for @cashInAmountSelectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get cashInAmountSelectWallet;

  /// No description provided for @cashInAmountRecipientUid.
  ///
  /// In en, this message translates to:
  /// **'Recipient UID'**
  String get cashInAmountRecipientUid;

  /// No description provided for @cashInAmountEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get cashInAmountEnterAmount;

  /// No description provided for @cashInAmountAmountRange.
  ///
  /// In en, this message translates to:
  /// **'Minimum {minAmount} {currency} and Maximum {maxAmount} {currency}'**
  String cashInAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  );

  /// No description provided for @cashInAmountContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get cashInAmountContinueButton;

  /// No description provided for @cashInAmountDropdownWalletNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet not found'**
  String get cashInAmountDropdownWalletNotFound;

  /// No description provided for @cashInAmountQrInvalidDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR code. Recipient UID must be digits only.'**
  String get cashInAmountQrInvalidDigitsOnly;

  /// No description provided for @cashInAmountQrInvalidPrefixNotFound.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR code. UID prefix not found.'**
  String get cashInAmountQrInvalidPrefixNotFound;

  /// No description provided for @comment_cash_in_review_section.
  ///
  /// In en, this message translates to:
  /// **'==== Cash In Review Section ===='**
  String get comment_cash_in_review_section;

  /// No description provided for @cashInReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Details'**
  String get cashInReviewTitle;

  /// No description provided for @cashInReviewAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get cashInReviewAmount;

  /// No description provided for @cashInReviewCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get cashInReviewCharge;

  /// No description provided for @cashInReviewAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get cashInReviewAccount;

  /// No description provided for @cashInReviewWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get cashInReviewWallet;

  /// No description provided for @cashInReviewTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cashInReviewTotal;

  /// No description provided for @cashInReviewCashInButton.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get cashInReviewCashInButton;

  /// No description provided for @comment_cash_in_success_section.
  ///
  /// In en, this message translates to:
  /// **'==== Cash In Success Section ===='**
  String get comment_cash_in_success_section;

  /// No description provided for @cashInSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash In Successful'**
  String get cashInSuccessTitle;

  /// No description provided for @cashInSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your funds have been successfully cashin.'**
  String get cashInSuccessDescription;

  /// No description provided for @cashInSuccessAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get cashInSuccessAmount;

  /// No description provided for @cashInSuccessTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get cashInSuccessTransactionId;

  /// No description provided for @cashInSuccessWalletName.
  ///
  /// In en, this message translates to:
  /// **'Wallet Name'**
  String get cashInSuccessWalletName;

  /// No description provided for @cashInSuccessAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get cashInSuccessAccountNumber;

  /// No description provided for @cashInSuccessCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get cashInSuccessCharge;

  /// No description provided for @cashInSuccessType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get cashInSuccessType;

  /// No description provided for @cashInSuccessFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get cashInSuccessFinalAmount;

  /// No description provided for @cashInSuccessBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get cashInSuccessBackHome;

  /// No description provided for @cashInSuccessAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get cashInSuccessAgain;

  /// No description provided for @comment_exchange_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Controller ===='**
  String get comment_exchange_controller;

  /// No description provided for @exchangeValidationSelectFromWallet.
  ///
  /// In en, this message translates to:
  /// **'Please select a from wallet'**
  String get exchangeValidationSelectFromWallet;

  /// No description provided for @exchangeValidationSelectToWallet.
  ///
  /// In en, this message translates to:
  /// **'Please select a to wallet'**
  String get exchangeValidationSelectToWallet;

  /// No description provided for @exchangeValidationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get exchangeValidationEnterAmount;

  /// No description provided for @exchangeValidationAmountMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount should be {amount} {currency}'**
  String exchangeValidationAmountMinimum(Object amount, Object currency);

  /// No description provided for @exchangeValidationAmountMaximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount should be {amount} {currency}'**
  String exchangeValidationAmountMaximum(Object amount, Object currency);

  /// No description provided for @comment_exchange_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Screen ===='**
  String get comment_exchange_screen;

  /// No description provided for @exchangeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchangeScreenTitle;

  /// No description provided for @comment_exchange_amount_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Amount Section ===='**
  String get comment_exchange_amount_section;

  /// No description provided for @exchangeAmountSelectFromWallet.
  ///
  /// In en, this message translates to:
  /// **'Select From Wallet'**
  String get exchangeAmountSelectFromWallet;

  /// No description provided for @exchangeAmountSelectToWallet.
  ///
  /// In en, this message translates to:
  /// **'Select To Wallet'**
  String get exchangeAmountSelectToWallet;

  /// No description provided for @exchangeAmountEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeAmountEnterAmount;

  /// No description provided for @exchangeAmountAmountRange.
  ///
  /// In en, this message translates to:
  /// **'Minimum {minAmount} {currency} and Maximum {maxAmount} {currency}'**
  String exchangeAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  );

  /// No description provided for @exchangeAmountExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate:'**
  String get exchangeAmountExchangeRate;

  /// No description provided for @exchangeAmountExchangeButton.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchangeAmountExchangeButton;

  /// No description provided for @exchangeAmountDropdownFromWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'From Wallets Not Found'**
  String get exchangeAmountDropdownFromWalletsNotFound;

  /// No description provided for @exchangeAmountDropdownToWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'To Wallets Not Found'**
  String get exchangeAmountDropdownToWalletsNotFound;

  /// No description provided for @comment_exchange_review_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Review Section ===='**
  String get comment_exchange_review_section;

  /// No description provided for @exchangeReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange Review'**
  String get exchangeReviewTitle;

  /// No description provided for @exchangeReviewAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeReviewAmount;

  /// No description provided for @exchangeReviewFromWallet.
  ///
  /// In en, this message translates to:
  /// **'From Wallet'**
  String get exchangeReviewFromWallet;

  /// No description provided for @exchangeReviewCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get exchangeReviewCharge;

  /// No description provided for @exchangeReviewTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get exchangeReviewTotalAmount;

  /// No description provided for @exchangeReviewToWallet.
  ///
  /// In en, this message translates to:
  /// **'To Wallet'**
  String get exchangeReviewToWallet;

  /// No description provided for @exchangeReviewExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeReviewExchangeRate;

  /// No description provided for @exchangeReviewExchangeAmount.
  ///
  /// In en, this message translates to:
  /// **'Exchange Amount'**
  String get exchangeReviewExchangeAmount;

  /// No description provided for @exchangeReviewExchangeNowButton.
  ///
  /// In en, this message translates to:
  /// **'Exchange Now'**
  String get exchangeReviewExchangeNowButton;

  /// No description provided for @comment_exchange_success_section.
  ///
  /// In en, this message translates to:
  /// **'==== Exchange Success Section ===='**
  String get comment_exchange_success_section;

  /// No description provided for @exchangeSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange Successful'**
  String get exchangeSuccessTitle;

  /// No description provided for @exchangeSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your exchange have been successfully'**
  String get exchangeSuccessSubtitle;

  /// No description provided for @exchangeSuccessAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get exchangeSuccessAmount;

  /// No description provided for @exchangeSuccessTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get exchangeSuccessTransactionId;

  /// No description provided for @exchangeSuccessPayAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay Amount'**
  String get exchangeSuccessPayAmount;

  /// No description provided for @exchangeSuccessConvertedAmount.
  ///
  /// In en, this message translates to:
  /// **'Converted Amount'**
  String get exchangeSuccessConvertedAmount;

  /// No description provided for @exchangeSuccessCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get exchangeSuccessCharge;

  /// No description provided for @exchangeSuccessDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get exchangeSuccessDate;

  /// No description provided for @exchangeSuccessFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get exchangeSuccessFinalAmount;

  /// No description provided for @exchangeSuccessBackHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get exchangeSuccessBackHomeButton;

  /// No description provided for @exchangeSuccessAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get exchangeSuccessAgainButton;

  /// No description provided for @comment_home_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Home Controller ===='**
  String get comment_home_controller;

  /// No description provided for @homeControllerBiometricDeviceNotSupported.
  ///
  /// In en, this message translates to:
  /// **'This device does not support biometrics.'**
  String get homeControllerBiometricDeviceNotSupported;

  /// No description provided for @homeControllerBiometricEnableSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric enabled successfully'**
  String get homeControllerBiometricEnableSuccess;

  /// No description provided for @homeControllerBiometricDisableSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric disabled successfully'**
  String get homeControllerBiometricDisableSuccess;

  /// No description provided for @homeControllerBiometricAuthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Biometric setting not changed.'**
  String get homeControllerBiometricAuthenticationFailed;

  /// No description provided for @homeControllerLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logout successful'**
  String get homeControllerLogoutSuccess;

  /// No description provided for @homeControllerBiometricDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric Not Found'**
  String get homeControllerBiometricDialogTitle;

  /// No description provided for @homeControllerBiometricDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'No fingerprint or biometric is enrolled on this device. You can set it up from the system settings.'**
  String get homeControllerBiometricDialogMessage;

  /// No description provided for @homeControllerBiometricDialogOpenSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Security Settings'**
  String get homeControllerBiometricDialogOpenSettingsButton;

  /// No description provided for @homeControllerIosBiometricInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please go to Settings > Face ID & Passcode to set up biometrics.'**
  String get homeControllerIosBiometricInstructions;

  /// No description provided for @comment_home_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Home Screen ===='**
  String get comment_home_screen;

  /// No description provided for @homeScreenTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get homeScreenTransactionHistory;

  /// No description provided for @homeScreenSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeScreenSeeAll;

  /// No description provided for @comment_all_menus_section.
  ///
  /// In en, this message translates to:
  /// **'==== All Menus Section ===='**
  String get comment_all_menus_section;

  /// No description provided for @allMenusSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get allMenusSectionTitle;

  /// No description provided for @allMenusSectionMyWallets.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get allMenusSectionMyWallets;

  /// No description provided for @allMenusSectionQrCode.
  ///
  /// In en, this message translates to:
  /// **'Qr Code'**
  String get allMenusSectionQrCode;

  /// No description provided for @allMenusSectionAddMoney.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get allMenusSectionAddMoney;

  /// No description provided for @allMenusSectionCashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get allMenusSectionCashIn;

  /// No description provided for @allMenusSectionExchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get allMenusSectionExchange;

  /// No description provided for @allMenusSectionWithdrawMoney.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Money'**
  String get allMenusSectionWithdrawMoney;

  /// No description provided for @allMenusSectionProfitHistory.
  ///
  /// In en, this message translates to:
  /// **'Profit History'**
  String get allMenusSectionProfitHistory;

  /// No description provided for @allMenusSectionTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get allMenusSectionTransactions;

  /// No description provided for @allMenusSectionLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get allMenusSectionLogout;

  /// No description provided for @allMenusSectionAccountNumberCopied.
  ///
  /// In en, this message translates to:
  /// **'Account Number Copied'**
  String get allMenusSectionAccountNumberCopied;

  /// No description provided for @allMenusSectionAid.
  ///
  /// In en, this message translates to:
  /// **'AID: {accountNumber}'**
  String allMenusSectionAid(Object accountNumber);

  /// No description provided for @comment_home_header_section.
  ///
  /// In en, this message translates to:
  /// **'==== Home Header Section ===='**
  String get comment_home_header_section;

  /// No description provided for @homeHeaderSectionAccountNumberCopied.
  ///
  /// In en, this message translates to:
  /// **'Account Number Copied'**
  String get homeHeaderSectionAccountNumberCopied;

  /// No description provided for @homeHeaderSectionAid.
  ///
  /// In en, this message translates to:
  /// **'AID: {accountNumber}'**
  String homeHeaderSectionAid(Object accountNumber);

  /// No description provided for @comment_home_quick_links.
  ///
  /// In en, this message translates to:
  /// **'==== Home Quick Links Section ===='**
  String get comment_home_quick_links;

  /// No description provided for @homeQuickLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get homeQuickLinksTitle;

  /// No description provided for @homeQuickLinksQrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get homeQuickLinksQrCode;

  /// No description provided for @homeQuickLinksMyWallets.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get homeQuickLinksMyWallets;

  /// No description provided for @homeQuickLinksAddMoney.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get homeQuickLinksAddMoney;

  /// No description provided for @homeQuickLinksCashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get homeQuickLinksCashIn;

  /// No description provided for @homeQuickLinksWithdrawMoney.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Money'**
  String get homeQuickLinksWithdrawMoney;

  /// No description provided for @homeQuickLinksProfitHistory.
  ///
  /// In en, this message translates to:
  /// **'Profit History'**
  String get homeQuickLinksProfitHistory;

  /// No description provided for @homeQuickLinksTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get homeQuickLinksTransactions;

  /// No description provided for @homeQuickLinksSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get homeQuickLinksSupport;

  /// No description provided for @comment_home_transaction_details.
  ///
  /// In en, this message translates to:
  /// **'==== Home Transaction Details Section ===='**
  String get comment_home_transaction_details;

  /// No description provided for @homeTransactionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get homeTransactionDetailsTitle;

  /// No description provided for @homeTransactionDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get homeTransactionDetailsDescription;

  /// No description provided for @homeTransactionDetailsWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get homeTransactionDetailsWallet;

  /// No description provided for @homeTransactionDetailsCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get homeTransactionDetailsCharge;

  /// No description provided for @homeTransactionDetailsTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get homeTransactionDetailsTransactionId;

  /// No description provided for @homeTransactionDetailsMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get homeTransactionDetailsMethod;

  /// No description provided for @homeTransactionDetailsTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get homeTransactionDetailsTotalAmount;

  /// No description provided for @homeTransactionDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get homeTransactionDetailsStatus;

  /// No description provided for @comment_home_wallets_section.
  ///
  /// In en, this message translates to:
  /// **'==== Home Wallets Section ===='**
  String get comment_home_wallets_section;

  /// No description provided for @homeWalletsSectionTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get homeWalletsSectionTopUp;

  /// No description provided for @homeWalletsSectionWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get homeWalletsSectionWithdraw;

  /// No description provided for @homeWalletsSectionAddWallet.
  ///
  /// In en, this message translates to:
  /// **'Add Wallet'**
  String get homeWalletsSectionAddWallet;

  /// No description provided for @comment_profile_section.
  ///
  /// In en, this message translates to:
  /// **'==== Profile Section ===='**
  String get comment_profile_section;

  /// No description provided for @profileSectionAccountNumberCopied.
  ///
  /// In en, this message translates to:
  /// **'Account Number Copied'**
  String get profileSectionAccountNumberCopied;

  /// No description provided for @profileSectionProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSectionProfileSettings;

  /// No description provided for @profileSectionChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileSectionChangePassword;

  /// No description provided for @profileSectionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileSectionNotifications;

  /// No description provided for @profileSectionSupportTickets.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get profileSectionSupportTickets;

  /// No description provided for @profileSectionLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileSectionLogout;

  /// No description provided for @profileSectionAccountNumberDisplay.
  ///
  /// In en, this message translates to:
  /// **'AID: {accountNumber}'**
  String profileSectionAccountNumberDisplay(Object accountNumber);

  /// No description provided for @comment_id_verification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== ID Verification Screen ===='**
  String get comment_id_verification_screen;

  /// No description provided for @idVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get idVerificationTitle;

  /// No description provided for @idVerificationHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get idVerificationHistory;

  /// No description provided for @idVerificationCenter.
  ///
  /// In en, this message translates to:
  /// **'Verification Center'**
  String get idVerificationCenter;

  /// No description provided for @idVerificationNothingToSubmit.
  ///
  /// In en, this message translates to:
  /// **'You have nothing to submit'**
  String get idVerificationNothingToSubmit;

  /// No description provided for @idVerificationStatusVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Center'**
  String get idVerificationStatusVerifiedTitle;

  /// No description provided for @idVerificationStatusVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have submitted your documents and it is verified'**
  String get idVerificationStatusVerifiedMessage;

  /// No description provided for @idVerificationStatusPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Center'**
  String get idVerificationStatusPendingTitle;

  /// No description provided for @idVerificationStatusPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'You have submitted your documents and it is awaiting for the approval'**
  String get idVerificationStatusPendingMessage;

  /// No description provided for @idVerificationStatusFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Center'**
  String get idVerificationStatusFailedTitle;

  /// No description provided for @idVerificationStatusFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your KYC verification has failed. Please resubmit the documents.'**
  String get idVerificationStatusFailedMessage;

  /// No description provided for @idVerificationStatusNotSubmittedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have not submitted any KYC documents yet'**
  String get idVerificationStatusNotSubmittedMessage;

  /// No description provided for @comment_kyc_history_screen.
  ///
  /// In en, this message translates to:
  /// **'==== KYC History Screen ===='**
  String get comment_kyc_history_screen;

  /// No description provided for @kycHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'KYC History'**
  String get kycHistoryTitle;

  /// No description provided for @kycHistoryDate.
  ///
  /// In en, this message translates to:
  /// **'Date: {formattedDate}'**
  String kycHistoryDate(Object formattedDate);

  /// No description provided for @kycHistoryStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get kycHistoryStatus;

  /// No description provided for @kycHistoryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get kycHistoryStatusPending;

  /// No description provided for @kycHistoryStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get kycHistoryStatusApproved;

  /// No description provided for @kycHistoryStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get kycHistoryStatusRejected;

  /// No description provided for @kycHistoryViewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get kycHistoryViewButton;

  /// No description provided for @comment_kyc_details_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== KYC Details Bottom Sheet ===='**
  String get comment_kyc_details_bottom_sheet;

  /// No description provided for @kycDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'KYC Details'**
  String get kycDetailsTitle;

  /// No description provided for @kycDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get kycDetailsStatus;

  /// No description provided for @kycDetailsCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created At:'**
  String get kycDetailsCreatedAt;

  /// No description provided for @kycDetailsMessageFromAdmin.
  ///
  /// In en, this message translates to:
  /// **'Message From Admin:'**
  String get kycDetailsMessageFromAdmin;

  /// No description provided for @kycDetailsSubmittedData.
  ///
  /// In en, this message translates to:
  /// **'Submitted Data'**
  String get kycDetailsSubmittedData;

  /// No description provided for @kycDetailsStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get kycDetailsStatusPending;

  /// No description provided for @kycDetailsStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get kycDetailsStatusApproved;

  /// No description provided for @kycDetailsStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get kycDetailsStatusRejected;

  /// No description provided for @comment_notification_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Notification Screen ===='**
  String get comment_notification_screen;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTitle;

  /// No description provided for @notificationMarkAll.
  ///
  /// In en, this message translates to:
  /// **'Mark All'**
  String get notificationMarkAll;

  /// No description provided for @comment_profit_history_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Profit History Screen ===='**
  String get comment_profit_history_screen;

  /// No description provided for @profitHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Profit History'**
  String get profitHistoryTitle;

  /// No description provided for @comment_profit_history_filter_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Profit History Filter Bottom Sheet ===='**
  String get comment_profit_history_filter_bottom_sheet;

  /// No description provided for @profitHistoryFilterTransactionIdHint.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get profitHistoryFilterTransactionIdHint;

  /// No description provided for @profitHistoryFilterSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get profitHistoryFilterSearchButton;

  /// No description provided for @comment_qr_code_screen.
  ///
  /// In en, this message translates to:
  /// **'==== QR Code Screen ===='**
  String get comment_qr_code_screen;

  /// No description provided for @qrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'My Qr Code'**
  String get qrCodeTitle;

  /// No description provided for @qrCodeScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Qr Code'**
  String get qrCodeScanTitle;

  /// No description provided for @qrCodeAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'AID: {accountNumber}'**
  String qrCodeAccountNumber(Object accountNumber);

  /// No description provided for @qrCodeDownloadButton.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get qrCodeDownloadButton;

  /// No description provided for @qrCodeDownloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Downloaded successfully!'**
  String get qrCodeDownloadSuccess;

  /// No description provided for @qrCodePermissionError.
  ///
  /// In en, this message translates to:
  /// **'Permission is required. Please allow it in settings.'**
  String get qrCodePermissionError;

  /// No description provided for @comment_change_password_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Change Password Controller Messages ===='**
  String get comment_change_password_controller;

  /// No description provided for @changePasswordCurrentPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an current password'**
  String get changePasswordCurrentPasswordEmpty;

  /// No description provided for @changePasswordNewPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an new password'**
  String get changePasswordNewPasswordEmpty;

  /// No description provided for @changePasswordPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get changePasswordPasswordLength;

  /// No description provided for @changePasswordConfirmPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an confirm password'**
  String get changePasswordConfirmPasswordEmpty;

  /// No description provided for @changePasswordPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get changePasswordPasswordsDoNotMatch;

  /// No description provided for @comment_change_password_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Change Password Screen ===='**
  String get comment_change_password_screen;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordCurrentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get changePasswordCurrentPasswordHint;

  /// No description provided for @changePasswordNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get changePasswordNewPasswordHint;

  /// No description provided for @changePasswordConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get changePasswordConfirmPasswordHint;

  /// No description provided for @changePasswordSaveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get changePasswordSaveChangesButton;

  /// No description provided for @comment_profile_settings_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Profile Settings Screen ===='**
  String get comment_profile_settings_screen;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileSettingsTitle;

  /// No description provided for @profileSettingsFirstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get profileSettingsFirstNameHint;

  /// No description provided for @profileSettingsLastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get profileSettingsLastNameHint;

  /// No description provided for @profileSettingsUserNameHint.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get profileSettingsUserNameHint;

  /// No description provided for @profileSettingsGenderHint.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileSettingsGenderHint;

  /// No description provided for @profileSettingsGenderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Gender not found'**
  String get profileSettingsGenderNotFound;

  /// No description provided for @profileSettingsGenderSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get profileSettingsGenderSelectTitle;

  /// No description provided for @profileSettingsDateOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get profileSettingsDateOfBirthHint;

  /// No description provided for @profileSettingsEmailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profileSettingsEmailAddressHint;

  /// No description provided for @profileSettingsPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profileSettingsPhoneHint;

  /// No description provided for @profileSettingsCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get profileSettingsCountryHint;

  /// No description provided for @profileSettingsCountryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Country not found'**
  String get profileSettingsCountryNotFound;

  /// No description provided for @profileSettingsCountrySelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get profileSettingsCountrySelectTitle;

  /// No description provided for @profileSettingsCityHint.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get profileSettingsCityHint;

  /// No description provided for @profileSettingsZipCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get profileSettingsZipCodeHint;

  /// No description provided for @profileSettingsJoiningDateHint.
  ///
  /// In en, this message translates to:
  /// **'Joining Date'**
  String get profileSettingsJoiningDateHint;

  /// No description provided for @profileSettingsAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get profileSettingsAddressHint;

  /// No description provided for @profileSettingsSaveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSettingsSaveChangesButton;

  /// No description provided for @comment_two_fa_authentication_screen.
  ///
  /// In en, this message translates to:
  /// **'==== 2FA Authentication Screen ===='**
  String get comment_two_fa_authentication_screen;

  /// No description provided for @twoFaAuthenticationTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get twoFaAuthenticationTitle;

  /// No description provided for @comment_disable_two_fa_section.
  ///
  /// In en, this message translates to:
  /// **'==== Disable 2FA Section ===='**
  String get comment_disable_two_fa_section;

  /// No description provided for @disableTwoFaTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get disableTwoFaTitle;

  /// No description provided for @disableTwoFaInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to disable 2FA'**
  String get disableTwoFaInstructions;

  /// No description provided for @disableTwoFaPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an password'**
  String get disableTwoFaPasswordEmpty;

  /// No description provided for @disableTwoFaDisableButton.
  ///
  /// In en, this message translates to:
  /// **'Disable 2FA'**
  String get disableTwoFaDisableButton;

  /// No description provided for @comment_enable_two_fa_section.
  ///
  /// In en, this message translates to:
  /// **'==== Enable 2FA Section ===='**
  String get comment_enable_two_fa_section;

  /// No description provided for @enableTwoFaTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get enableTwoFaTitle;

  /// No description provided for @enableTwoFaInstructions.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code with Google Authenticator\nApp to enable 2FA'**
  String get enableTwoFaInstructions;

  /// No description provided for @enableTwoFaPinLabel.
  ///
  /// In en, this message translates to:
  /// **'The PIN From Google Authenticator App'**
  String get enableTwoFaPinLabel;

  /// No description provided for @enableTwoFaPinEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an google authentication pin'**
  String get enableTwoFaPinEmpty;

  /// No description provided for @enableTwoFaEnableButton.
  ///
  /// In en, this message translates to:
  /// **'Enable 2FA'**
  String get enableTwoFaEnableButton;

  /// No description provided for @comment_generate_qr_code_section.
  ///
  /// In en, this message translates to:
  /// **'==== Generate QR Code Section ===='**
  String get comment_generate_qr_code_section;

  /// No description provided for @generateQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get generateQrCodeTitle;

  /// No description provided for @generateQrCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Enhance your account security with two-factor authentication'**
  String get generateQrCodeDescription;

  /// No description provided for @generateQrCodeGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Generate 2FA'**
  String get generateQrCodeGenerateButton;

  /// No description provided for @comment_settings_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Settings Screen ===='**
  String get comment_settings_screen;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get settingsProfileSettings;

  /// No description provided for @settingsChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsChangePassword;

  /// No description provided for @settingsTwoFaAuthentication.
  ///
  /// In en, this message translates to:
  /// **'2FA Authentication'**
  String get settingsTwoFaAuthentication;

  /// No description provided for @settingsIdVerification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get settingsIdVerification;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Language not found'**
  String get settingsLanguageNotFound;

  /// No description provided for @settingsLanguageSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsLanguageSelectTitle;

  /// No description provided for @settingsBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get settingsBiometric;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @comment_add_new_ticket_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Add New Ticket Controller Messages ===='**
  String get comment_add_new_ticket_controller;

  /// No description provided for @addNewTicketTitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get addNewTicketTitleEmpty;

  /// No description provided for @addNewTicketDescriptionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get addNewTicketDescriptionEmpty;

  /// No description provided for @addNewTicketGeneralError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get addNewTicketGeneralError;

  /// No description provided for @addNewTicketSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ticket created successfully'**
  String get addNewTicketSuccess;

  /// No description provided for @comment_add_new_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Add New Ticket Screen ===='**
  String get comment_add_new_ticket_screen;

  /// No description provided for @addNewTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Ticket'**
  String get addNewTicketTitle;

  /// No description provided for @addNewTicketTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Title'**
  String get addNewTicketTitleHint;

  /// No description provided for @addNewTicketDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get addNewTicketDescriptionHint;

  /// No description provided for @addNewTicketAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get addNewTicketAttachments;

  /// No description provided for @addNewTicketAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach File'**
  String get addNewTicketAttachFile;

  /// No description provided for @addNewTicketAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Ticket'**
  String get addNewTicketAddButton;

  /// No description provided for @comment_reply_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Reply Ticket Screen ===='**
  String get comment_reply_ticket_screen;

  /// No description provided for @replyTicketCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get replyTicketCloseButton;

  /// No description provided for @replyTicketMessageEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an message'**
  String get replyTicketMessageEmpty;

  /// No description provided for @replyTicketUnknownFile.
  ///
  /// In en, this message translates to:
  /// **'Unknown file'**
  String get replyTicketUnknownFile;

  /// No description provided for @replyTicketAttachmentPreview.
  ///
  /// In en, this message translates to:
  /// **'Attachment Preview'**
  String get replyTicketAttachmentPreview;

  /// No description provided for @replyTicketAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments:'**
  String get replyTicketAttachments;

  /// No description provided for @replyTicketTypeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type your message'**
  String get replyTicketTypeMessageHint;

  /// No description provided for @replyTicketSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get replyTicketSendButton;

  /// No description provided for @comment_support_ticket_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Support Ticket Screen ===='**
  String get comment_support_ticket_screen;

  /// No description provided for @supportTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Ticket'**
  String get supportTicketTitle;

  /// No description provided for @supportTicketCreateTicketButton.
  ///
  /// In en, this message translates to:
  /// **'Create Ticket'**
  String get supportTicketCreateTicketButton;

  /// No description provided for @comment_transactions_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Transactions Screen ===='**
  String get comment_transactions_screen;

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsTitle;

  /// No description provided for @comment_transaction_details_drop_down.
  ///
  /// In en, this message translates to:
  /// **'==== Transaction Details Drop Down ===='**
  String get comment_transaction_details_drop_down;

  /// No description provided for @transactionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetailsTitle;

  /// No description provided for @transactionDetailsWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get transactionDetailsWallet;

  /// No description provided for @transactionDetailsCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get transactionDetailsCharge;

  /// No description provided for @transactionDetailsTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionDetailsTransactionId;

  /// No description provided for @transactionDetailsMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get transactionDetailsMethod;

  /// No description provided for @transactionDetailsTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get transactionDetailsTotalAmount;

  /// No description provided for @transactionDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get transactionDetailsStatus;

  /// No description provided for @transactionDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get transactionDetailsDescription;

  /// No description provided for @comment_transaction_filter_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Transaction Filter Bottom Sheet ===='**
  String get comment_transaction_filter_bottom_sheet;

  /// No description provided for @transactionFilterTransactionIdHint.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionFilterTransactionIdHint;

  /// No description provided for @transactionFilterSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get transactionFilterSearchButton;

  /// No description provided for @comment_create_new_wallet_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Create New Wallet Screen ===='**
  String get comment_create_new_wallet_screen;

  /// No description provided for @createNewWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Wallet'**
  String get createNewWalletTitle;

  /// No description provided for @createNewWalletCurrencyHint.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get createNewWalletCurrencyHint;

  /// No description provided for @createNewWalletCurrencyNotFound.
  ///
  /// In en, this message translates to:
  /// **'Currency not found'**
  String get createNewWalletCurrencyNotFound;

  /// No description provided for @createNewWalletCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createNewWalletCreateButton;

  /// No description provided for @createNewWalletCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get createNewWalletCurrencyTitle;

  /// No description provided for @comment_delete_wallet_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Delete Wallet Bottom Sheet ===='**
  String get comment_delete_wallet_bottom_sheet;

  /// No description provided for @deleteWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteWalletTitle;

  /// No description provided for @deleteWalletMessage.
  ///
  /// In en, this message translates to:
  /// **'Once you delete your data, you won\'t be able to revert this!'**
  String get deleteWalletMessage;

  /// No description provided for @deleteWalletConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get deleteWalletConfirmButton;

  /// No description provided for @comment_wallet_details_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Wallet Details Screen ===='**
  String get comment_wallet_details_screen;

  /// No description provided for @walletDetailsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get walletDetailsHistory;

  /// No description provided for @walletDetailsTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get walletDetailsTopUp;

  /// No description provided for @walletDetailsWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletDetailsWithdraw;

  /// No description provided for @walletDetailsWalletsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallets Not Found'**
  String get walletDetailsWalletsNotFound;

  /// No description provided for @comment_wallets_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Wallets Screen ===='**
  String get comment_wallets_screen;

  /// No description provided for @walletsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Wallets'**
  String get walletsTitle;

  /// No description provided for @walletsTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get walletsTopUp;

  /// No description provided for @walletsWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletsWithdraw;

  /// No description provided for @walletsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get walletsDelete;

  /// No description provided for @comment_create_withdraw_account_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Create Withdraw Account Controller Messages ===='**
  String get comment_create_withdraw_account_controller;

  /// No description provided for @createWithdrawAccountWalletEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please select a wallet'**
  String get createWithdrawAccountWalletEmpty;

  /// No description provided for @createWithdrawAccountMethodEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please select a withdraw method'**
  String get createWithdrawAccountMethodEmpty;

  /// No description provided for @createWithdrawAccountMethodNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an method name'**
  String get createWithdrawAccountMethodNameEmpty;

  /// No description provided for @createWithdrawAccountFileRequired.
  ///
  /// In en, this message translates to:
  /// **'File required for {fieldName}'**
  String createWithdrawAccountFileRequired(Object fieldName);

  /// No description provided for @createWithdrawAccountFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Field {fieldName} is required'**
  String createWithdrawAccountFieldRequired(Object fieldName);

  /// No description provided for @createWithdrawAccountFieldFill.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the {fieldName} field'**
  String createWithdrawAccountFieldFill(Object fieldName);

  /// No description provided for @createWithdrawAccountFileUpload.
  ///
  /// In en, this message translates to:
  /// **'Please upload a file for {fieldName}'**
  String createWithdrawAccountFileUpload(Object fieldName);

  /// No description provided for @comment_withdraw_controller.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Controller Messages ===='**
  String get comment_withdraw_controller;

  /// No description provided for @withdrawAccountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please select a withdraw account'**
  String get withdrawAccountEmpty;

  /// No description provided for @withdrawAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get withdrawAmountEmpty;

  /// No description provided for @withdrawAmountMinError.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount should be {minAmount} {currency}'**
  String withdrawAmountMinError(Object currency, Object minAmount);

  /// No description provided for @withdrawAmountMaxError.
  ///
  /// In en, this message translates to:
  /// **'Maximum amount should be {maxAmount} {currency}'**
  String withdrawAmountMaxError(Object currency, Object maxAmount);

  /// No description provided for @comment_create_withdraw_account_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Create Withdraw Account Screen ===='**
  String get comment_create_withdraw_account_screen;

  /// No description provided for @createWithdrawAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Withdraw Account'**
  String get createWithdrawAccountTitle;

  /// No description provided for @createWithdrawAccountSelectWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get createWithdrawAccountSelectWalletLabel;

  /// No description provided for @createWithdrawAccountSelectMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Method'**
  String get createWithdrawAccountSelectMethodLabel;

  /// No description provided for @createWithdrawAccountWalletNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet not found'**
  String get createWithdrawAccountWalletNotFound;

  /// No description provided for @createWithdrawAccountMethodNotFound.
  ///
  /// In en, this message translates to:
  /// **'Withdraw method not found'**
  String get createWithdrawAccountMethodNotFound;

  /// No description provided for @createWithdrawAccountMethodNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Method Name'**
  String get createWithdrawAccountMethodNameLabel;

  /// No description provided for @createWithdrawAccountCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createWithdrawAccountCreateButton;

  /// No description provided for @comment_edit_withdraw_account_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Edit Withdraw Account Screen ===='**
  String get comment_edit_withdraw_account_screen;

  /// No description provided for @editWithdrawAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Withdraw Account'**
  String get editWithdrawAccountTitle;

  /// No description provided for @editWithdrawAccountMethodNameHint.
  ///
  /// In en, this message translates to:
  /// **'Method name'**
  String get editWithdrawAccountMethodNameHint;

  /// No description provided for @editWithdrawAccountUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get editWithdrawAccountUpdateButton;

  /// No description provided for @comment_delete_account_dropdown_section.
  ///
  /// In en, this message translates to:
  /// **'==== Delete Account Dropdown Section ===='**
  String get comment_delete_account_dropdown_section;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'You want to delete this account?'**
  String get deleteAccountMessage;

  /// No description provided for @deleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get deleteAccountConfirmButton;

  /// No description provided for @comment_withdraw_account_filter_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Account Filter Bottom Sheet ===='**
  String get comment_withdraw_account_filter_bottom_sheet;

  /// No description provided for @withdrawAccountFilterAccountNameHint.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get withdrawAccountFilterAccountNameHint;

  /// No description provided for @withdrawAccountFilterSearchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get withdrawAccountFilterSearchButton;

  /// No description provided for @comment_withdraw_account_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Account Section ===='**
  String get comment_withdraw_account_section;

  /// No description provided for @withdrawAccountSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'All Account'**
  String get withdrawAccountSectionTitle;

  /// No description provided for @comment_withdraw_amount_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Amount Step Section ===='**
  String get comment_withdraw_amount_step_section;

  /// No description provided for @withdrawAmountSelectAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Select Withdraw Account'**
  String get withdrawAmountSelectAccountHint;

  /// No description provided for @withdrawAmountAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawAmountAmountHint;

  /// No description provided for @withdrawAmountContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get withdrawAmountContinueButton;

  /// No description provided for @withdrawAmountRangeMessage.
  ///
  /// In en, this message translates to:
  /// **'Minimum {min} {currency} and Maximum {max} {currency}'**
  String withdrawAmountRangeMessage(Object currency, Object max, Object min);

  /// No description provided for @withdrawAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Account'**
  String get withdrawAccountTitle;

  /// No description provided for @withdrawAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'No withdraw accounts found'**
  String get withdrawAccountNotFound;

  /// No description provided for @withdrawAccountCurrencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Currency: {currency}'**
  String withdrawAccountCurrencySubtitle(Object currency);

  /// No description provided for @withdrawAccountMinMaxDescription.
  ///
  /// In en, this message translates to:
  /// **'Min: {min} | Max: {max}'**
  String withdrawAccountMinMaxDescription(Object max, Object min);

  /// No description provided for @comment_withdraw_pending_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Pending Step Section ===='**
  String get comment_withdraw_pending_step_section;

  /// No description provided for @withdrawPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Pending'**
  String get withdrawPendingTitle;

  /// No description provided for @withdrawPendingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your funds have been pending withdrawn.'**
  String get withdrawPendingSubtitle;

  /// No description provided for @withdrawPendingAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawPendingAmount;

  /// No description provided for @withdrawPendingTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transection ID'**
  String get withdrawPendingTransactionId;

  /// No description provided for @withdrawPendingCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get withdrawPendingCharge;

  /// No description provided for @withdrawPendingTransactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get withdrawPendingTransactionType;

  /// No description provided for @withdrawPendingFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get withdrawPendingFinalAmount;

  /// No description provided for @withdrawPendingBackHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get withdrawPendingBackHomeButton;

  /// No description provided for @withdrawPendingAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get withdrawPendingAgainButton;

  /// No description provided for @comment_withdraw_review_step_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Review Step Section ===='**
  String get comment_withdraw_review_step_section;

  /// No description provided for @withdrawReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Details'**
  String get withdrawReviewTitle;

  /// No description provided for @withdrawReviewAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get withdrawReviewAmount;

  /// No description provided for @withdrawReviewCharge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get withdrawReviewCharge;

  /// No description provided for @withdrawReviewTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get withdrawReviewTotal;

  /// No description provided for @withdrawReviewWithdrawButton.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Now'**
  String get withdrawReviewWithdrawButton;

  /// No description provided for @comment_withdraw_toggle_section.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Toggle Section ===='**
  String get comment_withdraw_toggle_section;

  /// No description provided for @withdrawToggleWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdrawToggleWithdraw;

  /// No description provided for @withdrawToggleAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get withdrawToggleAccount;

  /// No description provided for @comment_withdraw_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Withdraw Screen ===='**
  String get comment_withdraw_screen;

  /// No description provided for @withdrawScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Money'**
  String get withdrawScreenTitle;

  /// No description provided for @withdrawScreenAddAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get withdrawScreenAddAccountButton;

  /// No description provided for @comment_dynamic_attachment_preview.
  ///
  /// In en, this message translates to:
  /// **'==== Dynamic Attachment Preview ===='**
  String get comment_dynamic_attachment_preview;

  /// No description provided for @dynamicAttachmentPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachment Preview'**
  String get dynamicAttachmentPreviewTitle;

  /// No description provided for @comment_no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'==== No Internet Connection Screen ===='**
  String get comment_no_internet_connection;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// No description provided for @noInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check your network settings'**
  String get noInternetMessage;

  /// No description provided for @noInternetRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get noInternetRetryButton;

  /// No description provided for @comment_qr_scanner_screen.
  ///
  /// In en, this message translates to:
  /// **'==== QR Scanner Screen ===='**
  String get comment_qr_scanner_screen;

  /// No description provided for @qrScannerInstruction.
  ///
  /// In en, this message translates to:
  /// **'Place QR code within the frame to scan'**
  String get qrScannerInstruction;

  /// No description provided for @qrScannerProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get qrScannerProcessing;

  /// No description provided for @comment_web_view_screen.
  ///
  /// In en, this message translates to:
  /// **'==== Web View Screen ===='**
  String get comment_web_view_screen;

  /// No description provided for @webViewPaymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get webViewPaymentSuccess;

  /// No description provided for @webViewPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed!'**
  String get webViewPaymentFailed;

  /// No description provided for @webViewPaymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment was cancelled!'**
  String get webViewPaymentCancelled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
