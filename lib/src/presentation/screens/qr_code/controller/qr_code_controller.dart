import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/qr_code/model/qr_code_model.dart';

class QrCodeController extends GetxController {
  // Global variables
  final RxBool isLoading = false.obs;
  final Rx<QrCodeModel> qrCodeModel = QrCodeModel().obs;

  // Fetch QR
  Future<void> fetchQrCode() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.qrCodeEndpoint,
      );
      if (response.status == Status.completed) {
        qrCodeModel.value = QrCodeModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchQrCode() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }
}
