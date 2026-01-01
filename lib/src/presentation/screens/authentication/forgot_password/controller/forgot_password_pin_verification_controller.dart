import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class ForgotPasswordPinVerificationController extends GetxController {
  // Global Variable
  final RxBool isPinEnabled = true.obs;
  final RxBool isLoading = false.obs;
  final RxInt countdown = 30.obs;
  Timer? _timer;

  // Pin Code
  final pinCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  // Start Timer
  void startTimer() {
    countdown.value = 30;
    isPinEnabled.value = true;
    pinCodeController.clear();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        pinCodeController.clear();
        isPinEnabled.value = false;
        _timer?.cancel();
      }
    });
  }

  // Reset Verify OTP Function
  Future<void> submitResetVerifyOtp({required String email}) async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {
        "otp": pinCodeController.text,
        "email": email,
      };
      _timer?.cancel();
      final response = await Get.find<NetworkService>().globalPost(
        endpoint: ApiPath.resetVerifyOtpEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        Get.offNamed(
          BaseRoute.resetPassword,
          arguments: {"email": email, "otp": pinCodeController.text},
        );
        ToastHelper().showSuccessToast(response.data!["message"]);
        pinCodeController.clear();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitResetVerifyOtp() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
