import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/model/user_profile_model.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/model/agent_kyc_model.dart';

class SignUpStatusController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isFcmTokenLoading = false.obs;
  final RxBool isKycLoading = false.obs;
  final RxList<AgentKycData> userKycList = <AgentKycData>[].obs;
  final Rx<UserProfileModel> userModel = UserProfileModel().obs;

  // Verification Type
  final RxString typeName = "".obs;

  // Fetch User Kyc
  Future<void> fetchUserKyc() async {
    isKycLoading.value = true;
    typeName.value = "";
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: "${ApiPath.userKycEndpoint}?for=agent",
      );
      if (response.status == Status.completed) {
        final userKycModel = AgentKycModel.fromJson(response.data!);
        userKycList.clear();
        userKycList.assignAll(userKycModel.data!);
      } else {
        typeName.value = "";
        userKycList.clear();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUserKyc() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isKycLoading.value = false;
    }
  }

  // Fetch User
  Future<void> fetchUser() async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getUserProfileEndpoint,
      );
      if (response.status == Status.completed) {
        userModel.value = UserProfileModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUser() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postFcmNotification() async {
    isFcmTokenLoading.value = true;
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final savedFcmToken = await SettingsService.getFcmToken();
      String deviceId = '';
      String deviceType = '';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceType = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceType = 'ios';
      } else {
        deviceType = 'unknown';
        deviceId = 'unknown';
      }

      final Map<String, String> requestBody = {
        'device_id': deviceId,
        'device_type': deviceType,
        'fcm_token': savedFcmToken ?? '',
      };

      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.getSetupFcm,
        data: requestBody,
      );

      if (response.status == Status.completed) {
        Get.offAllNamed(
          BaseRoute.navigation,
          arguments: {
            "bonus": Get.find<SettingsService>().getSetting("referral_bonus"),
          },
        );
      }
    } finally {
      isFcmTokenLoading.value = false;
    }
  }

  // Reset Fields
  void reset() {
    userModel.value = UserProfileModel();
    typeName.value = "";
    userKycList.clear();
  }
}
