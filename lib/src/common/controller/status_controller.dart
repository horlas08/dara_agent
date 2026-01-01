import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/common/model/status_model.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class StatusController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;

  // User Profile Data
  final RxList<Statuses> statusList = <Statuses>[].obs;

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    await fetchStatus();
    isLoading.value = false;
  }

  // Fetch Status From API
  Future<void> fetchStatus() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getTransactionsTypesAndStatusEndpoint,
      );
      if (response.status == Status.completed) {
        final statusModel = StatusModel.fromJson(response.data!);
        statusList.clear();
        statusList.value = statusModel.data!.statuses ?? [];
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchStatus() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }
}
