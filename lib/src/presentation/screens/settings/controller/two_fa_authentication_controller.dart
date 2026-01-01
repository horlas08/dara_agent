import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class TwoFaAuthenticationController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final RxBool isEnableTwoFaLoading = false.obs;
  final RxBool isDisableTwoFaLoading = false.obs;
  final RxBool isGenerateQRCodeLoading = false.obs;
  final UserProfileController userProfileController = Get.find();

  // QR Code
  final RxString qrCode = "".obs;

  // Enable Two FA Controller
  final enable2FaController = TextEditingController();

  // Disable Two FA Controller
  final disable2FaController = TextEditingController();

  // Get QR Code
  Future<void> getQRCode() async {
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.twoFaGenerateQRCodeEndpoint,
      );
      if (response.status == Status.completed) {
        qrCode.value = "";
        qrCode.value = response.data?["data"]["qr_code"] ?? "";
      }
    } catch (e, stackTrace) {
      debugPrint('❌ getQRCode() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }

  Future<void> loadGenerate2Fa() async {
    isGenerateQRCodeLoading.value = true;
    await getQRCode();
    await userProfileController.fetchUserProfile();
    isGenerateQRCodeLoading.value = false;
  }

  // Enable Two Factor
  Future<void> submitEnableTwoFa() async {
    isEnableTwoFaLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.enableTwoFaEndpoint,
        data: {"one_time_password": enable2FaController.text},
      );
      if (response.status == Status.completed) {
        await userProfileController.fetchUserProfile();
        enable2FaController.clear();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitEnableTwoFa() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isEnableTwoFaLoading.value = false;
    }
  }

  // Disable Two factor
  Future<void> submitDisableTwoFa() async {
    isDisableTwoFaLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.disableTwoFaEndpoint,
        data: {"one_time_password": disable2FaController.text},
      );
      if (response.status == Status.completed) {
        await userProfileController.fetchUserProfile();
        disable2FaController.clear();
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitDisableTwoFa() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isDisableTwoFaLoading.value = false;
    }
  }
}
