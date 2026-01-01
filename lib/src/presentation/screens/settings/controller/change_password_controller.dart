import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class ChangePasswordController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final localization = AppLocalizations.of(Get.context!)!;

  // Current Password
  final RxBool isCurrentPasswordVisible = true.obs;
  final currentPasswordController = TextEditingController();

  // New Password
  final RxBool isNewPasswordVisible = true.obs;
  final newPasswordController = TextEditingController();

  // Confirm Password
  final RxBool isConfirmPasswordVisible = true.obs;
  final confirmPasswordController = TextEditingController();

  // Change Password
  Future<void> changePassword() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {
        "current_password": currentPasswordController.text,
        "password": newPasswordController.text,
        "password_confirmation": confirmPasswordController.text,
      };

      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.changePasswordEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        ToastHelper().showSuccessToast(response.data!["message"]);
        Get.find<HomeController>().submitLogout();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ changePassword() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isLoading.value = false;
    }
  }

  // Validate Password
  bool validatePassword() {
    if (currentPasswordController.text.isEmpty) {
      ToastHelper().showErrorToast(
        localization.changePasswordCurrentPasswordEmpty,
      );
      return false;
    }

    if (newPasswordController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.changePasswordNewPasswordEmpty);
      return false;
    }

    if (newPasswordController.text.length < 8) {
      ToastHelper().showErrorToast(localization.changePasswordPasswordLength);
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      ToastHelper().showErrorToast(
        localization.changePasswordConfirmPasswordEmpty,
      );
      return false;
    }

    if (confirmPasswordController.text != newPasswordController.text) {
      ToastHelper().showErrorToast(
        localization.changePasswordPasswordsDoNotMatch,
      );
      return false;
    }

    return true;
  }
}
