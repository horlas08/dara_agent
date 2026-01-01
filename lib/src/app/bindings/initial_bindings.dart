import 'package:get/get.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TokenService>(TokenService());
    Get.put<SettingsService>(SettingsService());
    Get.put<NetworkService>(NetworkService());
  }
}
