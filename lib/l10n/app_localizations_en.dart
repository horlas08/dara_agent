// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get comment_common_alert_bottom_sheet =>
      '==== Common Alert Bottom Sheet ====';

  @override
  String get commonAlertConfirmButton => 'Confirm';

  @override
  String get commonAlertCancelButton => 'Cancel';

  @override
  String get comment_common_alert => '==== Common Alert ====';

  @override
  String get commonAlertExitTitle => 'Exit Application';

  @override
  String get commonAlertExitMessage =>
      'Are you sure you want to exit the application?';

  @override
  String get comment_image_picker_dropdown_bottom_sheet =>
      '==== Image Picker Dropdown Bottom Sheet ====';

  @override
  String get imagePickerDropdownTitle => 'Select Image Source';

  @override
  String get imagePickerDropdownCamera => 'Camera';

  @override
  String get imagePickerDropdownGallery => 'Gallery';

  @override
  String get comment_common_country_dropdown =>
      '==== Common Country Dropdown ====';

  @override
  String get countryDropdownSearchHint => 'Search';

  @override
  String get countryDropdownNotFound => 'Country not found';

  @override
  String get comment_all_controller => '==== All Controller ====';

  @override
  String get allControllerLoadError => 'Something went wrong!';

  @override
  String get comment_splash_screen => '==== Splash Screen ====';

  @override
  String get splashAgentBadge => 'Agent';

  @override
  String get comment_agent_navigation_screen =>
      '==== Agent Navigation Screen ====';

  @override
  String get agentNavigationBottomNavHome => 'Home';

  @override
  String get agentNavigationBottomNavWallets => 'Wallets';

  @override
  String get agentNavigationBottomNavTransactions => 'Transactions';

  @override
  String get agentNavigationBottomNavSettings => 'Settings';

  @override
  String get agentNavigationQrInvalidFormat =>
      'Invalid QR code. Must be digits only or in UID format.';

  @override
  String get comment_image_picker_controller =>
      '==== Image Picker Controller ====';

  @override
  String get imagePickerGalleryError => 'Failed to pick image from gallery';

  @override
  String get imagePickerCameraError => 'Failed to pick image from camera';

  @override
  String get comment_biometric_auth_service =>
      '==== Biometric Auth Service ====';

  @override
  String get biometricDeviceNotSupported =>
      'This device does not support biometrics.';

  @override
  String get biometricNotEnrolled =>
      'No biometric enrolled. Please set up fingerprint';

  @override
  String get biometricUnavailable =>
      'Biometric features are currently unavailable.';

  @override
  String get biometricAuthenticationFailed =>
      'Biometric authentication failed.';

  @override
  String get biometricCheckFailed => 'Unable to check biometric availability.';

  @override
  String get biometricAuthReason => 'Authenticate to log in';

  @override
  String get comment_network_service => '==== Network Service ====';

  @override
  String get networkErrorGeneric =>
      'An unexpected error occurred. Please try again.';

  @override
  String get networkErrorTimeout => 'Request timed out. Please try again.';

  @override
  String get networkErrorNoInternet => 'No internet connection';

  @override
  String get networkErrorUnauthorized =>
      'You are not authorized to access this resource. Please log in again!';

  @override
  String get networkErrorOccurred => 'An error occurred. Please try again.';

  @override
  String get unauthorizedDialogTitle => 'Unauthorized';

  @override
  String get unauthorizedDialogDescription =>
      'You are not authorized to access this resource. Please log in again!';

  @override
  String get unauthorizedDialogButton => 'OK';

  @override
  String get comment_add_money_controller => '==== Add Money Controller ====';

  @override
  String get addMoneySuccess => 'Money added successfully';

  @override
  String get validationSelectWallet => 'Please select a wallet';

  @override
  String get validationSelectGateway => 'Please select a gateway';

  @override
  String get validationEnterAmount => 'Please enter an amount';

  @override
  String get validationAmountGreaterThanZero => 'Amount must be greater than 0';

  @override
  String validationAmountMinimumDeposit(Object amount) {
    return 'Minimum deposit amount is $amount';
  }

  @override
  String validationAmountMaximumDeposit(Object amount) {
    return 'Maximum deposit amount is $amount';
  }

  @override
  String validationUploadFile(Object fieldName) {
    return 'Please upload a file for $fieldName';
  }

  @override
  String validationFillField(Object fieldName) {
    return 'Please fill in the $fieldName field';
  }

  @override
  String get comment_add_money_screen => '==== Add Money Screen ====';

  @override
  String get addMoneyScreenTitle => 'Add Money';

  @override
  String get comment_add_money_amount_section =>
      '==== Add Money Amount Section ====';

  @override
  String get addMoneySelectWallet => 'Select Wallet';

  @override
  String get addMoneySelectGateway => 'Select Gateway';

  @override
  String get addMoneyEnterAmount => 'Amount';

  @override
  String addMoneyAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'Minimum $minAmount $currency and Maximum $maxAmount $currency';
  }

  @override
  String get addMoneyContinueButton => 'Continue';

  @override
  String get addMoneyDropdownWalletNotFound => 'Wallet not found';

  @override
  String get addMoneyDropdownGatewayNotFound => 'Gateway not found';

  @override
  String get addMoneyDropdownSelectWallet => 'Select Wallet';

  @override
  String get addMoneyDropdownSelectGateway => 'Select Gateway';

  @override
  String get comment_add_money_pending_section =>
      '==== Add Money Pending Section ====';

  @override
  String get addMoneyPendingTitle => 'Your Deposit Process is Pending';

  @override
  String get addMoneyPendingDescription =>
      'Your funds have been successfully add money.';

  @override
  String get addMoneyAmount => 'Amount';

  @override
  String get addMoneyTransactionId => 'Transaction ID';

  @override
  String get addMoneyWalletName => 'Wallet Name';

  @override
  String get addMoneyPaymentMethod => 'Payment Method';

  @override
  String get addMoneyCharge => 'Charge';

  @override
  String get addMoneyType => 'Type';

  @override
  String get addMoneyFinalAmount => 'Final Amount';

  @override
  String get addMoneyBackHome => 'Back Home';

  @override
  String get addMoneyAgain => 'Again';

  @override
  String get comment_add_money_review_section =>
      '==== Add Money Review Section ====';

  @override
  String get addMoneyReviewTitle => 'Review Details';

  @override
  String get addMoneyReviewAmount => 'Amount';

  @override
  String get addMoneyReviewWalletName => 'Wallet Name';

  @override
  String get addMoneyReviewPaymentMethod => 'Payment Method';

  @override
  String get addMoneyReviewCharge => 'Charge';

  @override
  String get addMoneyReviewTotal => 'Total';

  @override
  String get addMoneyReviewAddMoneyButton => 'Add Money';

  @override
  String get comment_add_money_success_section =>
      '==== Add Money Success Section ====';

  @override
  String get addMoneySuccessTitle => 'Deposit Money Successful';

  @override
  String get addMoneySuccessDescription =>
      'Your funds have been successfully deposit.';

  @override
  String get addMoneySuccessAmount => 'Amount';

  @override
  String get addMoneySuccessTransactionId => 'Transaction ID';

  @override
  String get addMoneySuccessCharge => 'Charge';

  @override
  String get addMoneySuccessType => 'Type';

  @override
  String get addMoneySuccessFinalAmount => 'Final Amount';

  @override
  String get addMoneySuccessBackHome => 'Back Home';

  @override
  String get addMoneySuccessAgain => 'Again';

  @override
  String get comment_forgot_password_screen =>
      '==== Forgot Password Screen ====';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordEmailHint => 'Email';

  @override
  String get forgotPasswordSendButton => 'Send Verification Link';

  @override
  String get forgotPasswordBackButton => 'Back';

  @override
  String get forgotPasswordEmailRequired => 'The email field is required';

  @override
  String get comment_forgot_password_pin_verification =>
      '==== Forgot Password Pin Verification ====';

  @override
  String get forgotPasswordPinVerifyTitle => 'Verify Email';

  @override
  String get forgotPasswordPinVerifyOtpSent => 'OTP sent to ';

  @override
  String forgotPasswordPinVerifyCountdown(Object seconds) {
    return 'OTP in ${seconds}s';
  }

  @override
  String get forgotPasswordPinVerifyContinue => 'Continue';

  @override
  String get forgotPasswordPinVerifyBack => 'Back';

  @override
  String get forgotPasswordPinRequired => 'The otp field is required';

  @override
  String get comment_reset_password_screen => '==== Reset Password Screen ====';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordHint => 'Password';

  @override
  String get resetPasswordConfirmHint => 'Confirm Password';

  @override
  String get resetPasswordButton => 'Reset';

  @override
  String get resetPasswordBackButton => 'Back';

  @override
  String get resetPasswordRequired => 'Password is required';

  @override
  String get resetPasswordMinLength => 'Password must be at least 8 characters';

  @override
  String get resetPasswordConfirmRequired => 'Please confirm your password';

  @override
  String get resetPasswordMismatch => 'Passwords don\'t match';

  @override
  String get comment_sign_in_controller => '==== Sign In Controller ====';

  @override
  String get signInEmailPasswordEmpty => 'Email and password cannot be empty.';

  @override
  String get signInEmailRequired => 'Please enter your email.';

  @override
  String get comment_sign_in_screen => '==== Sign In Screen ====';

  @override
  String get signInTitle => 'Agent Login!';

  @override
  String get signInEmailHint => 'Email';

  @override
  String get signInPasswordHint => 'Password';

  @override
  String get signInForgotPassword => 'Forgot Password';

  @override
  String get signInLoginButton => 'Login';

  @override
  String get signInNoAccount => 'Don\'t have an account? ';

  @override
  String get signInCreateAccount => 'Create One';

  @override
  String get signInBiometricPrompt => 'First Sign In with Email and Password';

  @override
  String get signInBiometricNotEnabled => 'Your biometric is not enabled';

  @override
  String get signInEmailFieldRequired => 'The email field is required';

  @override
  String get signInPasswordRequired => 'The password field is required';

  @override
  String get comment_auth_id_verification_screen =>
      '==== Auth ID Verification Screen ====';

  @override
  String get authIdVerificationInvalidField => 'Invalid field type';

  @override
  String authIdVerificationUnknownField(Object fieldType) {
    return 'Unknown field type: $fieldType';
  }

  @override
  String get comment_file_type_section => '==== File Type Section ====';

  @override
  String get fileTypeChooseFileButton => 'Choose File';

  @override
  String get comment_kyc_submission_section =>
      '==== KYC Submission Section ====';

  @override
  String get kycSubmissionTitle => 'ID Verification';

  @override
  String get kycSubmissionSubmitButton => 'Submit';

  @override
  String get kycSubmissionNextButton => 'Next';

  @override
  String get kycSubmissionReUploadButton => 'Re Upload';

  @override
  String get kycSubmissionRetakeButton => 'Retake';

  @override
  String get comment_submit_valid_id_verification =>
      '==== Submit Valid ID Verification ====';

  @override
  String get submitValidIdVerificationTitle =>
      'Submit a Valid ID for Verification';

  @override
  String get submitValidIdVerificationChooseIdType => 'Choose ID Type';

  @override
  String get comment_email_screen => '==== Email Screen ====';

  @override
  String get emailScreenTitle => 'Agent Register!';

  @override
  String get emailScreenEmailLabel => 'Email';

  @override
  String get emailScreenContinueButton => 'Continue';

  @override
  String get emailScreenBackButton => 'Back';

  @override
  String get emailRequired => 'Please enter an email';

  @override
  String get comment_personal_info_screen => '==== Personal Info Screen ====';

  @override
  String get personalInfoTitle => 'Agent Register!';

  @override
  String get personalInfoSubtitle => 'Personal Info';

  @override
  String get personalInfoFirstName => 'First Name';

  @override
  String get personalInfoLastName => 'Last Name';

  @override
  String get personalInfoUsername => 'Username';

  @override
  String get personalInfoSelectCountry => 'Select Country';

  @override
  String get personalInfoPhone => 'Phone';

  @override
  String get personalInfoSelectGender => 'Select Gender';

  @override
  String get personalInfoSubmitButton => 'Submit';

  @override
  String get personalInfoBackButton => 'Back';

  @override
  String get personalInfoDropdownSelectCountry => 'Select Country';

  @override
  String get personalInfoDropdownSelectGender => 'Select Gender';

  @override
  String get personalInfoDropdownGenderNotFound => 'Gender not found';

  @override
  String get personalInfoFirstNameRequired => 'First name is required';

  @override
  String get personalInfoLastNameRequired => 'Last name is required';

  @override
  String get personalInfoUsernameRequired => 'Username is required';

  @override
  String get personalInfoCountryRequired => 'Country is required';

  @override
  String get personalInfoPhoneRequired => 'Phone number is required';

  @override
  String get personalInfoGenderRequired => 'Gender is required';

  @override
  String get comment_set_up_password_screen =>
      '==== Set Up Password Screen ====';

  @override
  String get setUpPasswordTitle => 'Setup Password';

  @override
  String get setUpPasswordLabel => 'Password';

  @override
  String get setUpPasswordConfirmLabel => 'Confirm Password';

  @override
  String get setUpPasswordAgreeTerms => 'I agree with the ';

  @override
  String get setUpPasswordTermsConditions => 'Terms & Conditions';

  @override
  String get setUpPasswordButton => 'Setup Password';

  @override
  String get setUpPasswordBackButton => 'Back';

  @override
  String get setUpPasswordRequired => 'Password is required';

  @override
  String get setUpPasswordMinLength => 'Password must be at least 8 characters';

  @override
  String get setUpPasswordConfirmRequired => 'Please confirm your password';

  @override
  String get setUpPasswordMismatch => 'Passwords don\'t match';

  @override
  String get setUpPasswordAcceptTerms => 'Please accept terms and conditions';

  @override
  String get comment_sign_up_status_screen => '==== Sign Up Status Screen ====';

  @override
  String get signUpStatusTitle => 'Agent Register!';

  @override
  String get signUpStatusSubtitle =>
      'Let\'s Set up Your Agent Profile in a few Steps.';

  @override
  String get signUpStatusEmailVerification => 'Email Verification';

  @override
  String get signUpStatusSetupPassword => 'Setup Password';

  @override
  String get signUpStatusPersonalInfo => 'Personal Info';

  @override
  String get signUpStatusIdVerification => 'ID Verification';

  @override
  String get signUpStatusInReview => 'In Review';

  @override
  String get signUpStatusRejected => 'Rejected';

  @override
  String get signUpStatusNoReason => 'No reason provided';

  @override
  String get signUpStatusNextButton => 'Next';

  @override
  String get signUpStatusSubmitAgain => 'Submit Again';

  @override
  String get signUpStatusDashboard => 'Dashboard';

  @override
  String get signUpStatusBackButton => 'Back';

  @override
  String get signUpStatusErrorProcessing =>
      'Error processing next step. Please try again.';

  @override
  String get comment_verify_email_screen => '==== Verify Email Screen ====';

  @override
  String get verifyEmailTitle => 'Verify Email';

  @override
  String get verifyEmailOtpSent => 'OTP sent to ';

  @override
  String verifyEmailResendCountdown(Object seconds) {
    return 'Resend available in ${seconds}s';
  }

  @override
  String get verifyEmailResendReady => 'You can request a new OTP now';

  @override
  String get verifyEmailContinueButton => 'Continue';

  @override
  String get verifyEmailBackButton => 'Back';

  @override
  String get verifyEmailDidntReceive => 'Didn’t receive the code? ';

  @override
  String get verifyEmailResend => 'Resend';

  @override
  String get verifyEmailOtpRequired => 'The otp field is required';

  @override
  String get comment_two_factor_auth_screen =>
      '==== Two Factor Auth Screen ====';

  @override
  String get twoFactorAuthTitle => 'Verify Two Fa';

  @override
  String get twoFactorAuthVerifyButton => 'Verify';

  @override
  String get twoFactorAuthBackButton => 'Back';

  @override
  String get twoFactorAuthOtpRequired => 'The otp field is required';

  @override
  String get comment_welcome_screen => '==== Welcome Screen ====';

  @override
  String get welcomeScreenTitle => 'Welcome to Agent';

  @override
  String get welcomeScreenDescription =>
      'Your dashboard is ready. Track clients, manage finances, and grow';

  @override
  String get welcomeScreenCreateAccount => 'Create your account';

  @override
  String get welcomeScreenLogin => 'Login';

  @override
  String get comment_cash_in_controller => '==== Cash In Controller ====';

  @override
  String get cashInValidationEnterUserUid => 'Please enter an User UID';

  @override
  String get cashInValidationSelectWallet => 'Please select a wallet';

  @override
  String get cashInValidationEnterAmount => 'Please enter an amount';

  @override
  String cashInValidationAmountMinimum(Object amount, Object currency) {
    return 'Minimum amount should be $amount $currency';
  }

  @override
  String cashInValidationAmountMaximum(Object amount, Object currency) {
    return 'Maximum amount should be $amount $currency';
  }

  @override
  String get comment_cash_in_screen => '==== Cash In Screen ====';

  @override
  String get cashInScreenTitle => 'Cash In';

  @override
  String get comment_cash_in_amount_section =>
      '==== Cash In Amount Section ====';

  @override
  String get cashInAmountSelectWallet => 'Select Wallet';

  @override
  String get cashInAmountRecipientUid => 'Recipient UID';

  @override
  String get cashInAmountEnterAmount => 'Amount';

  @override
  String cashInAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'Minimum $minAmount $currency and Maximum $maxAmount $currency';
  }

  @override
  String get cashInAmountContinueButton => 'Continue';

  @override
  String get cashInAmountDropdownWalletNotFound => 'Wallet not found';

  @override
  String get cashInAmountQrInvalidDigitsOnly =>
      'Invalid QR code. Recipient UID must be digits only.';

  @override
  String get cashInAmountQrInvalidPrefixNotFound =>
      'Invalid QR code. UID prefix not found.';

  @override
  String get comment_cash_in_review_section =>
      '==== Cash In Review Section ====';

  @override
  String get cashInReviewTitle => 'Review Details';

  @override
  String get cashInReviewAmount => 'Amount';

  @override
  String get cashInReviewCharge => 'Charge';

  @override
  String get cashInReviewAccount => 'Account';

  @override
  String get cashInReviewWallet => 'Wallet';

  @override
  String get cashInReviewTotal => 'Total';

  @override
  String get cashInReviewCashInButton => 'Cash In';

  @override
  String get comment_cash_in_success_section =>
      '==== Cash In Success Section ====';

  @override
  String get cashInSuccessTitle => 'Cash In Successful';

  @override
  String get cashInSuccessDescription =>
      'Your funds have been successfully cashin.';

  @override
  String get cashInSuccessAmount => 'Amount';

  @override
  String get cashInSuccessTransactionId => 'Transaction ID';

  @override
  String get cashInSuccessWalletName => 'Wallet Name';

  @override
  String get cashInSuccessAccountNumber => 'Account Number';

  @override
  String get cashInSuccessCharge => 'Charge';

  @override
  String get cashInSuccessType => 'Type';

  @override
  String get cashInSuccessFinalAmount => 'Final Amount';

  @override
  String get cashInSuccessBackHome => 'Back Home';

  @override
  String get cashInSuccessAgain => 'Again';

  @override
  String get comment_exchange_controller => '==== Exchange Controller ====';

  @override
  String get exchangeValidationSelectFromWallet =>
      'Please select a from wallet';

  @override
  String get exchangeValidationSelectToWallet => 'Please select a to wallet';

  @override
  String get exchangeValidationEnterAmount => 'Please enter an amount';

  @override
  String exchangeValidationAmountMinimum(Object amount, Object currency) {
    return 'Minimum amount should be $amount $currency';
  }

  @override
  String exchangeValidationAmountMaximum(Object amount, Object currency) {
    return 'Maximum amount should be $amount $currency';
  }

  @override
  String get comment_exchange_screen => '==== Exchange Screen ====';

  @override
  String get exchangeScreenTitle => 'Exchange';

  @override
  String get comment_exchange_amount_section =>
      '==== Exchange Amount Section ====';

  @override
  String get exchangeAmountSelectFromWallet => 'Select From Wallet';

  @override
  String get exchangeAmountSelectToWallet => 'Select To Wallet';

  @override
  String get exchangeAmountEnterAmount => 'Amount';

  @override
  String exchangeAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'Minimum $minAmount $currency and Maximum $maxAmount $currency';
  }

  @override
  String get exchangeAmountExchangeRate => 'Exchange Rate:';

  @override
  String get exchangeAmountExchangeButton => 'Exchange';

  @override
  String get exchangeAmountDropdownFromWalletsNotFound =>
      'From Wallets Not Found';

  @override
  String get exchangeAmountDropdownToWalletsNotFound => 'To Wallets Not Found';

  @override
  String get comment_exchange_review_section =>
      '==== Exchange Review Section ====';

  @override
  String get exchangeReviewTitle => 'Exchange Review';

  @override
  String get exchangeReviewAmount => 'Amount';

  @override
  String get exchangeReviewFromWallet => 'From Wallet';

  @override
  String get exchangeReviewCharge => 'Charge';

  @override
  String get exchangeReviewTotalAmount => 'Total Amount';

  @override
  String get exchangeReviewToWallet => 'To Wallet';

  @override
  String get exchangeReviewExchangeRate => 'Exchange Rate';

  @override
  String get exchangeReviewExchangeAmount => 'Exchange Amount';

  @override
  String get exchangeReviewExchangeNowButton => 'Exchange Now';

  @override
  String get comment_exchange_success_section =>
      '==== Exchange Success Section ====';

  @override
  String get exchangeSuccessTitle => 'Exchange Successful';

  @override
  String get exchangeSuccessSubtitle => 'Your exchange have been successfully';

  @override
  String get exchangeSuccessAmount => 'Amount';

  @override
  String get exchangeSuccessTransactionId => 'Transaction ID';

  @override
  String get exchangeSuccessPayAmount => 'Pay Amount';

  @override
  String get exchangeSuccessConvertedAmount => 'Converted Amount';

  @override
  String get exchangeSuccessCharge => 'Charge';

  @override
  String get exchangeSuccessDate => 'Date';

  @override
  String get exchangeSuccessFinalAmount => 'Final Amount';

  @override
  String get exchangeSuccessBackHomeButton => 'Back Home';

  @override
  String get exchangeSuccessAgainButton => 'Again';

  @override
  String get comment_home_controller => '==== Home Controller ====';

  @override
  String get homeControllerBiometricDeviceNotSupported =>
      'This device does not support biometrics.';

  @override
  String get homeControllerBiometricEnableSuccess =>
      'Biometric enabled successfully';

  @override
  String get homeControllerBiometricDisableSuccess =>
      'Biometric disabled successfully';

  @override
  String get homeControllerBiometricAuthenticationFailed =>
      'Authentication failed. Biometric setting not changed.';

  @override
  String get homeControllerLogoutSuccess => 'Logout successful';

  @override
  String get homeControllerBiometricDialogTitle => 'Biometric Not Found';

  @override
  String get homeControllerBiometricDialogMessage =>
      'No fingerprint or biometric is enrolled on this device. You can set it up from the system settings.';

  @override
  String get homeControllerBiometricDialogOpenSettingsButton =>
      'Open Security Settings';

  @override
  String get homeControllerIosBiometricInstructions =>
      'Please go to Settings > Face ID & Passcode to set up biometrics.';

  @override
  String get comment_home_screen => '==== Home Screen ====';

  @override
  String get homeScreenTransactionHistory => 'Transaction History';

  @override
  String get homeScreenSeeAll => 'See All';

  @override
  String get comment_all_menus_section => '==== All Menus Section ====';

  @override
  String get allMenusSectionTitle => 'All Menus';

  @override
  String get allMenusSectionMyWallets => 'My Wallets';

  @override
  String get allMenusSectionQrCode => 'Qr Code';

  @override
  String get allMenusSectionAddMoney => 'Add Money';

  @override
  String get allMenusSectionCashIn => 'Cash In';

  @override
  String get allMenusSectionExchange => 'Exchange';

  @override
  String get allMenusSectionWithdrawMoney => 'Withdraw Money';

  @override
  String get allMenusSectionProfitHistory => 'Profit History';

  @override
  String get allMenusSectionTransactions => 'Transactions';

  @override
  String get allMenusSectionLogout => 'Logout';

  @override
  String get allMenusSectionAccountNumberCopied => 'Account Number Copied';

  @override
  String allMenusSectionAid(Object accountNumber) {
    return 'AID: $accountNumber';
  }

  @override
  String get comment_home_header_section => '==== Home Header Section ====';

  @override
  String get homeHeaderSectionAccountNumberCopied => 'Account Number Copied';

  @override
  String homeHeaderSectionAid(Object accountNumber) {
    return 'AID: $accountNumber';
  }

  @override
  String get comment_home_quick_links => '==== Home Quick Links Section ====';

  @override
  String get homeQuickLinksTitle => 'Quick Links';

  @override
  String get homeQuickLinksQrCode => 'QR Code';

  @override
  String get homeQuickLinksMyWallets => 'My Wallets';

  @override
  String get homeQuickLinksAddMoney => 'Add Money';

  @override
  String get homeQuickLinksCashIn => 'Cash In';

  @override
  String get homeQuickLinksWithdrawMoney => 'Withdraw Money';

  @override
  String get homeQuickLinksProfitHistory => 'Profit History';

  @override
  String get homeQuickLinksTransactions => 'Transactions';

  @override
  String get homeQuickLinksSupport => 'Support';

  @override
  String get comment_home_transaction_details =>
      '==== Home Transaction Details Section ====';

  @override
  String get homeTransactionDetailsTitle => 'Transaction Details';

  @override
  String get homeTransactionDetailsDescription => 'Description';

  @override
  String get homeTransactionDetailsWallet => 'Wallet';

  @override
  String get homeTransactionDetailsCharge => 'Charge';

  @override
  String get homeTransactionDetailsTransactionId => 'Transaction ID';

  @override
  String get homeTransactionDetailsMethod => 'Method';

  @override
  String get homeTransactionDetailsTotalAmount => 'Total Amount';

  @override
  String get homeTransactionDetailsStatus => 'Status';

  @override
  String get comment_home_wallets_section => '==== Home Wallets Section ====';

  @override
  String get homeWalletsSectionTopUp => 'Top Up';

  @override
  String get homeWalletsSectionWithdraw => 'Withdraw';

  @override
  String get homeWalletsSectionAddWallet => 'Add Wallet';

  @override
  String get comment_profile_section => '==== Profile Section ====';

  @override
  String get profileSectionAccountNumberCopied => 'Account Number Copied';

  @override
  String get profileSectionProfileSettings => 'Profile Settings';

  @override
  String get profileSectionChangePassword => 'Change Password';

  @override
  String get profileSectionNotifications => 'Notifications';

  @override
  String get profileSectionSupportTickets => 'Support Tickets';

  @override
  String get profileSectionLogout => 'Logout';

  @override
  String profileSectionAccountNumberDisplay(Object accountNumber) {
    return 'AID: $accountNumber';
  }

  @override
  String get comment_id_verification_screen =>
      '==== ID Verification Screen ====';

  @override
  String get idVerificationTitle => 'ID Verification';

  @override
  String get idVerificationHistory => 'History';

  @override
  String get idVerificationCenter => 'Verification Center';

  @override
  String get idVerificationNothingToSubmit => 'You have nothing to submit';

  @override
  String get idVerificationStatusVerifiedTitle => 'Verification Center';

  @override
  String get idVerificationStatusVerifiedMessage =>
      'You have submitted your documents and it is verified';

  @override
  String get idVerificationStatusPendingTitle => 'Verification Center';

  @override
  String get idVerificationStatusPendingMessage =>
      'You have submitted your documents and it is awaiting for the approval';

  @override
  String get idVerificationStatusFailedTitle => 'Verification Center';

  @override
  String get idVerificationStatusFailedMessage =>
      'Your KYC verification has failed. Please resubmit the documents.';

  @override
  String get idVerificationStatusNotSubmittedMessage =>
      'You have not submitted any KYC documents yet';

  @override
  String get comment_kyc_history_screen => '==== KYC History Screen ====';

  @override
  String get kycHistoryTitle => 'KYC History';

  @override
  String kycHistoryDate(Object formattedDate) {
    return 'Date: $formattedDate';
  }

  @override
  String get kycHistoryStatus => 'Status: ';

  @override
  String get kycHistoryStatusPending => 'Pending';

  @override
  String get kycHistoryStatusApproved => 'Approved';

  @override
  String get kycHistoryStatusRejected => 'Rejected';

  @override
  String get kycHistoryViewButton => 'View';

  @override
  String get comment_kyc_details_bottom_sheet =>
      '==== KYC Details Bottom Sheet ====';

  @override
  String get kycDetailsTitle => 'KYC Details';

  @override
  String get kycDetailsStatus => 'Status:';

  @override
  String get kycDetailsCreatedAt => 'Created At:';

  @override
  String get kycDetailsMessageFromAdmin => 'Message From Admin:';

  @override
  String get kycDetailsSubmittedData => 'Submitted Data';

  @override
  String get kycDetailsStatusPending => 'Pending';

  @override
  String get kycDetailsStatusApproved => 'Approved';

  @override
  String get kycDetailsStatusRejected => 'Rejected';

  @override
  String get comment_notification_screen => '==== Notification Screen ====';

  @override
  String get notificationTitle => 'Notification';

  @override
  String get notificationMarkAll => 'Mark All';

  @override
  String get comment_profit_history_screen => '==== Profit History Screen ====';

  @override
  String get profitHistoryTitle => 'Profit History';

  @override
  String get comment_profit_history_filter_bottom_sheet =>
      '==== Profit History Filter Bottom Sheet ====';

  @override
  String get profitHistoryFilterTransactionIdHint => 'Transaction ID';

  @override
  String get profitHistoryFilterSearchButton => 'Search';

  @override
  String get comment_qr_code_screen => '==== QR Code Screen ====';

  @override
  String get qrCodeTitle => 'My Qr Code';

  @override
  String get qrCodeScanTitle => 'Scan Qr Code';

  @override
  String qrCodeAccountNumber(Object accountNumber) {
    return 'AID: $accountNumber';
  }

  @override
  String get qrCodeDownloadButton => 'Download';

  @override
  String get qrCodeDownloadSuccess => 'Downloaded successfully!';

  @override
  String get qrCodePermissionError =>
      'Permission is required. Please allow it in settings.';

  @override
  String get comment_change_password_controller =>
      '==== Change Password Controller Messages ====';

  @override
  String get changePasswordCurrentPasswordEmpty =>
      'Please enter an current password';

  @override
  String get changePasswordNewPasswordEmpty => 'Please enter an new password';

  @override
  String get changePasswordPasswordLength =>
      'Password must be at least 8 characters';

  @override
  String get changePasswordConfirmPasswordEmpty =>
      'Please enter an confirm password';

  @override
  String get changePasswordPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get comment_change_password_screen =>
      '==== Change Password Screen ====';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get changePasswordCurrentPasswordHint => 'Current password';

  @override
  String get changePasswordNewPasswordHint => 'New password';

  @override
  String get changePasswordConfirmPasswordHint => 'Confirm password';

  @override
  String get changePasswordSaveChangesButton => 'Save Changes';

  @override
  String get comment_profile_settings_screen =>
      '==== Profile Settings Screen ====';

  @override
  String get profileSettingsTitle => 'Profile';

  @override
  String get profileSettingsFirstNameHint => 'First Name';

  @override
  String get profileSettingsLastNameHint => 'Last Name';

  @override
  String get profileSettingsUserNameHint => 'User Name';

  @override
  String get profileSettingsGenderHint => 'Gender';

  @override
  String get profileSettingsGenderNotFound => 'Gender not found';

  @override
  String get profileSettingsGenderSelectTitle => 'Select Gender';

  @override
  String get profileSettingsDateOfBirthHint => 'Date Of Birth';

  @override
  String get profileSettingsEmailAddressHint => 'Email Address';

  @override
  String get profileSettingsPhoneHint => 'Phone';

  @override
  String get profileSettingsCountryHint => 'Country';

  @override
  String get profileSettingsCountryNotFound => 'Country not found';

  @override
  String get profileSettingsCountrySelectTitle => 'Select Country';

  @override
  String get profileSettingsCityHint => 'City';

  @override
  String get profileSettingsZipCodeHint => 'Zip Code';

  @override
  String get profileSettingsJoiningDateHint => 'Joining Date';

  @override
  String get profileSettingsAddressHint => 'Address';

  @override
  String get profileSettingsSaveChangesButton => 'Save Changes';

  @override
  String get comment_two_fa_authentication_screen =>
      '==== 2FA Authentication Screen ====';

  @override
  String get twoFaAuthenticationTitle => '2FA Authentication';

  @override
  String get comment_disable_two_fa_section => '==== Disable 2FA Section ====';

  @override
  String get disableTwoFaTitle => '2FA Authentication';

  @override
  String get disableTwoFaInstructions => 'Enter your password to disable 2FA';

  @override
  String get disableTwoFaPasswordEmpty => 'Please enter an password';

  @override
  String get disableTwoFaDisableButton => 'Disable 2FA';

  @override
  String get comment_enable_two_fa_section => '==== Enable 2FA Section ====';

  @override
  String get enableTwoFaTitle => '2FA Authentication';

  @override
  String get enableTwoFaInstructions =>
      'Scan the QR code with Google Authenticator\nApp to enable 2FA';

  @override
  String get enableTwoFaPinLabel => 'The PIN From Google Authenticator App';

  @override
  String get enableTwoFaPinEmpty => 'Please enter an google authentication pin';

  @override
  String get enableTwoFaEnableButton => 'Enable 2FA';

  @override
  String get comment_generate_qr_code_section =>
      '==== Generate QR Code Section ====';

  @override
  String get generateQrCodeTitle => '2FA Authentication';

  @override
  String get generateQrCodeDescription =>
      'Enhance your account security with two-factor authentication';

  @override
  String get generateQrCodeGenerateButton => 'Generate 2FA';

  @override
  String get comment_settings_screen => '==== Settings Screen ====';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfileSettings => 'Profile Settings';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsTwoFaAuthentication => '2FA Authentication';

  @override
  String get settingsIdVerification => 'ID Verification';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageNotFound => 'Language not found';

  @override
  String get settingsLanguageSelectTitle => 'Select Language';

  @override
  String get settingsBiometric => 'Biometric';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get comment_add_new_ticket_controller =>
      '==== Add New Ticket Controller Messages ====';

  @override
  String get addNewTicketTitleEmpty => 'Please enter a title';

  @override
  String get addNewTicketDescriptionEmpty => 'Please enter a description';

  @override
  String get addNewTicketGeneralError => 'Something went wrong!';

  @override
  String get addNewTicketSuccess => 'Ticket created successfully';

  @override
  String get comment_add_new_ticket_screen => '==== Add New Ticket Screen ====';

  @override
  String get addNewTicketTitle => 'Create Ticket';

  @override
  String get addNewTicketTitleHint => 'Enter Title';

  @override
  String get addNewTicketDescriptionHint => 'Description';

  @override
  String get addNewTicketAttachments => 'Attachments';

  @override
  String get addNewTicketAttachFile => 'Attach File';

  @override
  String get addNewTicketAddButton => 'Add Ticket';

  @override
  String get comment_reply_ticket_screen => '==== Reply Ticket Screen ====';

  @override
  String get replyTicketCloseButton => 'Close';

  @override
  String get replyTicketMessageEmpty => 'Please enter an message';

  @override
  String get replyTicketUnknownFile => 'Unknown file';

  @override
  String get replyTicketAttachmentPreview => 'Attachment Preview';

  @override
  String get replyTicketAttachments => 'Attachments:';

  @override
  String get replyTicketTypeMessageHint => 'Type your message';

  @override
  String get replyTicketSendButton => 'Send';

  @override
  String get comment_support_ticket_screen => '==== Support Ticket Screen ====';

  @override
  String get supportTicketTitle => 'Support Ticket';

  @override
  String get supportTicketCreateTicketButton => 'Create Ticket';

  @override
  String get comment_transactions_screen => '==== Transactions Screen ====';

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get comment_transaction_details_drop_down =>
      '==== Transaction Details Drop Down ====';

  @override
  String get transactionDetailsTitle => 'Transaction Details';

  @override
  String get transactionDetailsWallet => 'Wallet';

  @override
  String get transactionDetailsCharge => 'Charge';

  @override
  String get transactionDetailsTransactionId => 'Transaction ID';

  @override
  String get transactionDetailsMethod => 'Method';

  @override
  String get transactionDetailsTotalAmount => 'Total Amount';

  @override
  String get transactionDetailsStatus => 'Status';

  @override
  String get transactionDetailsDescription => 'Description';

  @override
  String get comment_transaction_filter_bottom_sheet =>
      '==== Transaction Filter Bottom Sheet ====';

  @override
  String get transactionFilterTransactionIdHint => 'Transaction ID';

  @override
  String get transactionFilterSearchButton => 'Search';

  @override
  String get comment_create_new_wallet_screen =>
      '==== Create New Wallet Screen ====';

  @override
  String get createNewWalletTitle => 'Create New Wallet';

  @override
  String get createNewWalletCurrencyHint => 'Select Currency';

  @override
  String get createNewWalletCurrencyNotFound => 'Currency not found';

  @override
  String get createNewWalletCreateButton => 'Create';

  @override
  String get createNewWalletCurrencyTitle => 'Currency';

  @override
  String get comment_delete_wallet_bottom_sheet =>
      '==== Delete Wallet Bottom Sheet ====';

  @override
  String get deleteWalletTitle => 'Are you sure?';

  @override
  String get deleteWalletMessage =>
      'Once you delete your data, you won\'t be able to revert this!';

  @override
  String get deleteWalletConfirmButton => 'Confirm';

  @override
  String get comment_wallet_details_screen => '==== Wallet Details Screen ====';

  @override
  String get walletDetailsHistory => 'History';

  @override
  String get walletDetailsTopUp => 'Top Up';

  @override
  String get walletDetailsWithdraw => 'Withdraw';

  @override
  String get walletDetailsWalletsNotFound => 'Wallets Not Found';

  @override
  String get comment_wallets_screen => '==== Wallets Screen ====';

  @override
  String get walletsTitle => 'My Wallets';

  @override
  String get walletsTopUp => 'Top Up';

  @override
  String get walletsWithdraw => 'Withdraw';

  @override
  String get walletsDelete => 'Delete';

  @override
  String get comment_create_withdraw_account_controller =>
      '==== Create Withdraw Account Controller Messages ====';

  @override
  String get createWithdrawAccountWalletEmpty => 'Please select a wallet';

  @override
  String get createWithdrawAccountMethodEmpty =>
      'Please select a withdraw method';

  @override
  String get createWithdrawAccountMethodNameEmpty =>
      'Please enter an method name';

  @override
  String createWithdrawAccountFileRequired(Object fieldName) {
    return 'File required for $fieldName';
  }

  @override
  String createWithdrawAccountFieldRequired(Object fieldName) {
    return 'Field $fieldName is required';
  }

  @override
  String createWithdrawAccountFieldFill(Object fieldName) {
    return 'Please fill in the $fieldName field';
  }

  @override
  String createWithdrawAccountFileUpload(Object fieldName) {
    return 'Please upload a file for $fieldName';
  }

  @override
  String get comment_withdraw_controller =>
      '==== Withdraw Controller Messages ====';

  @override
  String get withdrawAccountEmpty => 'Please select a withdraw account';

  @override
  String get withdrawAmountEmpty => 'Please enter an amount';

  @override
  String withdrawAmountMinError(Object currency, Object minAmount) {
    return 'Minimum amount should be $minAmount $currency';
  }

  @override
  String withdrawAmountMaxError(Object currency, Object maxAmount) {
    return 'Maximum amount should be $maxAmount $currency';
  }

  @override
  String get comment_create_withdraw_account_screen =>
      '==== Create Withdraw Account Screen ====';

  @override
  String get createWithdrawAccountTitle => 'Create Withdraw Account';

  @override
  String get createWithdrawAccountSelectWalletLabel => 'Select Wallet';

  @override
  String get createWithdrawAccountSelectMethodLabel => 'Select Method';

  @override
  String get createWithdrawAccountWalletNotFound => 'Wallet not found';

  @override
  String get createWithdrawAccountMethodNotFound => 'Withdraw method not found';

  @override
  String get createWithdrawAccountMethodNameLabel => 'Method Name';

  @override
  String get createWithdrawAccountCreateButton => 'Create';

  @override
  String get comment_edit_withdraw_account_screen =>
      '==== Edit Withdraw Account Screen ====';

  @override
  String get editWithdrawAccountTitle => 'Edit Withdraw Account';

  @override
  String get editWithdrawAccountMethodNameHint => 'Method name';

  @override
  String get editWithdrawAccountUpdateButton => 'Update';

  @override
  String get comment_delete_account_dropdown_section =>
      '==== Delete Account Dropdown Section ====';

  @override
  String get deleteAccountTitle => 'Are you sure?';

  @override
  String get deleteAccountMessage => 'You want to delete this account?';

  @override
  String get deleteAccountConfirmButton => 'Confirm';

  @override
  String get comment_withdraw_account_filter_bottom_sheet =>
      '==== Withdraw Account Filter Bottom Sheet ====';

  @override
  String get withdrawAccountFilterAccountNameHint => 'Account Name';

  @override
  String get withdrawAccountFilterSearchButton => 'Search';

  @override
  String get comment_withdraw_account_section =>
      '==== Withdraw Account Section ====';

  @override
  String get withdrawAccountSectionTitle => 'All Account';

  @override
  String get comment_withdraw_amount_step_section =>
      '==== Withdraw Amount Step Section ====';

  @override
  String get withdrawAmountSelectAccountHint => 'Select Withdraw Account';

  @override
  String get withdrawAmountAmountHint => 'Amount';

  @override
  String get withdrawAmountContinueButton => 'Continue';

  @override
  String withdrawAmountRangeMessage(Object currency, Object max, Object min) {
    return 'Minimum $min $currency and Maximum $max $currency';
  }

  @override
  String get withdrawAccountTitle => 'Withdraw Account';

  @override
  String get withdrawAccountNotFound => 'No withdraw accounts found';

  @override
  String withdrawAccountCurrencySubtitle(Object currency) {
    return 'Currency: $currency';
  }

  @override
  String withdrawAccountMinMaxDescription(Object max, Object min) {
    return 'Min: $min | Max: $max';
  }

  @override
  String get comment_withdraw_pending_step_section =>
      '==== Withdraw Pending Step Section ====';

  @override
  String get withdrawPendingTitle => 'Withdrawal Pending';

  @override
  String get withdrawPendingSubtitle =>
      'Your funds have been pending withdrawn.';

  @override
  String get withdrawPendingAmount => 'Amount';

  @override
  String get withdrawPendingTransactionId => 'Transection ID';

  @override
  String get withdrawPendingCharge => 'Charge';

  @override
  String get withdrawPendingTransactionType => 'Transaction Type';

  @override
  String get withdrawPendingFinalAmount => 'Final Amount';

  @override
  String get withdrawPendingBackHomeButton => 'Back Home';

  @override
  String get withdrawPendingAgainButton => 'Again';

  @override
  String get comment_withdraw_review_step_section =>
      '==== Withdraw Review Step Section ====';

  @override
  String get withdrawReviewTitle => 'Review Details';

  @override
  String get withdrawReviewAmount => 'Amount';

  @override
  String get withdrawReviewCharge => 'Charge';

  @override
  String get withdrawReviewTotal => 'Total';

  @override
  String get withdrawReviewWithdrawButton => 'Withdraw Now';

  @override
  String get comment_withdraw_toggle_section =>
      '==== Withdraw Toggle Section ====';

  @override
  String get withdrawToggleWithdraw => 'Withdraw';

  @override
  String get withdrawToggleAccount => 'Account';

  @override
  String get comment_withdraw_screen => '==== Withdraw Screen ====';

  @override
  String get withdrawScreenTitle => 'Withdraw Money';

  @override
  String get withdrawScreenAddAccountButton => 'Add Account';

  @override
  String get comment_dynamic_attachment_preview =>
      '==== Dynamic Attachment Preview ====';

  @override
  String get dynamicAttachmentPreviewTitle => 'Attachment Preview';

  @override
  String get comment_no_internet_connection =>
      '==== No Internet Connection Screen ====';

  @override
  String get noInternetTitle => 'No Internet Connection';

  @override
  String get noInternetMessage => 'Please check your network settings';

  @override
  String get noInternetRetryButton => 'Retry';

  @override
  String get comment_qr_scanner_screen => '==== QR Scanner Screen ====';

  @override
  String get qrScannerInstruction => 'Place QR code within the frame to scan';

  @override
  String get qrScannerProcessing => 'Processing...';

  @override
  String get comment_web_view_screen => '==== Web View Screen ====';

  @override
  String get webViewPaymentSuccess => 'Payment Successful!';

  @override
  String get webViewPaymentFailed => 'Payment Failed!';

  @override
  String get webViewPaymentCancelled => 'Payment was cancelled!';
}
