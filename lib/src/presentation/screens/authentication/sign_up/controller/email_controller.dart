import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';

class EmailController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final bool isFromSignIn = Get.arguments?["from_sign_in"] ?? false;

  // Email
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    setLogInState();
  }

  // Clear Sign Up Status
  void clearSignUpStatus() async {
    await Get.find<SettingsService>().saveEmailVerified(false);
    await Get.find<SettingsService>().saveSetUpPassword(false);
    await Get.find<TokenService>().clearToken();
  }

  // Set Log In State Function
  Future<void> setLogInState() async {
    await Get.find<SettingsService>().saveLoginCurrentState("logged_in");
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Send Verify Email
  Future<void> sendVerifyEmail() async {
    final userEmail = emailController.text.trim();

    final checkEmailVerification =
        Get.find<SettingsService>().getSetting("email_verification") == "1";

    isLoading.value = true;
    try {
      final response = await NetworkService().globalPost(
        endpoint: ApiPath.verifyEmailEndpoint,
        data: {"email": userEmail},
      );
      if (response.status == Status.completed) {
        await Get.find<SettingsService>().saveLoggedInUserEmail(userEmail);
        if (checkEmailVerification) {
          Get.toNamed(
            BaseRoute.verifyEmail,
            arguments: {"from_sign_in": isFromSignIn, "user_email": userEmail},
          );
          emailController.clear();
          ToastHelper().showSuccessToast(response.data!["message"]);
        } else {
          await Get.find<SettingsService>().saveEmailVerified(true);
          Get.toNamed(
            BaseRoute.signUpStatus,
            arguments: {"from_sign_in": isFromSignIn, "user_email": userEmail},
          );
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ sendVerifyEmail() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
