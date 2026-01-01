import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class ForgotPasswordController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;

  // Email
  final emailController = TextEditingController();

  // Forgot Password Function
  Future<void> submitForgotPassword() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {
        "email": emailController.text.trim(),
      };
      final response = await Get.find<NetworkService>().globalPost(
        endpoint: ApiPath.forgotPasswordEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        Get.offNamed(
          BaseRoute.forgotPasswordPinVerification,
          arguments: {"email": emailController.text},
        );
        emailController.clear();
        ToastHelper().showSuccessToast(response.data?["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitForgotPassword() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
