import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class ResetPasswordController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;

  // Password
  final RxBool isPasswordVisible = true.obs;
  final passwordController = TextEditingController();

  // Confirm Password
  final RxBool isConfirmPasswordVisible = true.obs;
  final confirmPasswordController = TextEditingController();

  // Reset Password Function
  Future<void> submitResetPassword({
    required String email,
    required String otp,
  }) async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {
        "email": email,
        "otp": otp,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      };
      final response = await Get.find<NetworkService>().globalPost(
        endpoint: ApiPath.resetPasswordEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        Get.offNamed(BaseRoute.signIn);
        passwordController.clear();
        confirmPasswordController.clear();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitResetPassword() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
