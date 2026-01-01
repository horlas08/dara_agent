import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/model/register_fields_model.dart';

class RegisterFieldsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxMap<String, String> registerFields = <String, String>{}.obs;

  Future<void> loadRegisterFields() async {
    isLoading.value = true;
    await fetchRegisterFields();
    isLoading.value = false;
  }

  Future<void> fetchRegisterFields() async {
    try {
      final response = await Get.find<NetworkService>().globalGet(
        endpoint: ApiPath.getRegisterFieldsEndpoint,
      );
      if (response.status == Status.completed) {
        final RegisterFieldsModel jsonResponse = RegisterFieldsModel.fromJson(
          response.data!,
        );
        registerFields.clear();
        for (var field in jsonResponse.data!) {
          registerFields[field.key!] = field.value!;
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchRegisterFields() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }
}
