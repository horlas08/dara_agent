import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/id_verification/model/kyc_history_model.dart';

class KycHistoryController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final RxList<KycHistoryData> kycHistoryList = <KycHistoryData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKycHistory();
  }

  // Fetch KYC History
  Future<void> fetchKycHistory() async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.kycHistoryEndpoint,
      );
      if (response.status == Status.completed) {
        final kycHistoryModel = KycHistoryModel.fromJson(response.data!);
        kycHistoryList.clear();
        kycHistoryList.assignAll(kycHistoryModel.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchKycHistory() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
