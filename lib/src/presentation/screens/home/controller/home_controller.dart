import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/common/service/biometric_auth_service.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';
import 'package:qunzo_agent/src/presentation/screens/home/model/dashboard_model.dart';

class HomeController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isSignOutLoading = false.obs;
  final RxInt selectedIndex = 0.obs;
  final currentWalletIndex = 0.obs;
  final RxBool isBiometricEnable = false.obs;
  final Rx<DashboardModel> dashboardModel = DashboardModel().obs;
  final UserProfileController userProfileController = Get.find();
  GlobalKey<ScaffoldState>? scaffoldKey;
  final RxString language = "".obs;
  final languageController = TextEditingController();
  final localization = AppLocalizations.of(Get.context!)!;

  @override
  void onInit() {
    super.onInit();
    loadData();
    loadBiometricStatus();
  }

  // Load Biometric Status
  Future<void> loadBiometricStatus() async {
    final savedBiometric = await SettingsService.getBiometricEnableOrDisable();
    isBiometricEnable.value = savedBiometric ?? false;
  }

  Future<void> loadData() async {
    isLoading.value = true;
    if (Get.find<SettingsService>().getSetting("language_switcher") == "1") {
      _setInitialLanguage();
    }
    await userProfileController.fetchUserProfile();
    await fetchDashboard();
    isLoading.value = false;
  }

  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    scaffoldKey = key;
  }

  Future<void> _setInitialLanguage() async {
    final savedLocale = await SettingsService.getLanguageLocaleCurrentState();

    if (savedLocale != null) {
      if (savedLocale == "en") {
        language.value = "English";
        languageController.text = "English";
      }
    } else {
      language.value = "English";
      languageController.text = "English";
      await Get.find<SettingsService>().saveLanguageLocaleCurrentState("en");
    }
  }

  // Language Switching Method
  Future<void> changeLanguage(String languageName) async {
    try {
      language.value = languageName;
      languageController.text = languageName;

      String localeCode;
      if (languageName == "English") {
        localeCode = "en";
      } else {
        localeCode = "en";
      }
      await Get.find<SettingsService>().saveLanguageLocaleCurrentState(
        localeCode,
      );

      Get.updateLocale(Locale(localeCode));
    } catch (e, stackTrace) {
      debugPrint('❌ changeLanguage() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
    }
  }

  // Toggle Biometric
  Future<void> toggleBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final biometricAuthService = BiometricAuthService();
    final isSupported = await auth.isDeviceSupported();
    final isAvailable = await biometricAuthService.isBiometricAvailable();

    if (!isSupported) {
      ToastHelper().showErrorToast(
        localization.homeControllerBiometricDeviceNotSupported,
      );
      return;
    }
    if (!isAvailable) {
      _showBiometricNotAvailableDialog();
      return;
    }

    final isAuthenticated = await biometricAuthService
        .authenticateWithBiometrics();

    if (isAuthenticated) {
      isBiometricEnable.value = !isBiometricEnable.value;
      await Get.find<SettingsService>().saveBiometricEnableOrDisable(
        isBiometricEnable.value,
      );
      ToastHelper().showSuccessToast(
        isBiometricEnable.value
            ? localization.homeControllerBiometricEnableSuccess
            : localization.homeControllerBiometricDisableSuccess,
      );
    } else {
      ToastHelper().showErrorToast(
        localization.homeControllerBiometricAuthenticationFailed,
      );
    }
  }

  // Fetch Dashboard Function
  Future<void> fetchDashboard() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.dashboardEndpoint,
      );
      if (response.status == Status.completed) {
        dashboardModel.value = DashboardModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchDashboard() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {}
  }

  // Logout Function
  Future<void> submitLogout() async {
    isSignOutLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.logoutEndpoint,
      );

      if (response.status == Status.completed) {
        await Get.find<TokenService>().clearToken();
        Get.offAllNamed(BaseRoute.signIn);
        ToastHelper().showSuccessToast(response.data?["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitLogout() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isSignOutLoading.value = false;
    }
  }

  void _showBiometricNotAvailableDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Icon(Icons.fingerprint, size: 60, color: AppColors.lightPrimary),
            const SizedBox(height: 12),
            Text(
              localization.homeControllerBiometricDialogTitle,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                color: AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              localization.homeControllerBiometricDialogMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                fontSize: 16.0,
                height: 1.5,
                color: AppColors.lightTextTertiary,
              ),
            ),
            const SizedBox(height: 24.0),
            CommonButton(
              width: double.infinity,
              height: 54,
              text:
                  localization.homeControllerBiometricDialogOpenSettingsButton,
              onPressed: () => _openSecuritySettings(),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  void _openSecuritySettings() {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.SECURITY_SETTINGS',
      );
      intent.launch();
    } else if (Platform.isIOS) {
      ToastHelper().showWarningToast(
        localization.homeControllerIosBiometricInstructions,
      );
    }
  }
}
