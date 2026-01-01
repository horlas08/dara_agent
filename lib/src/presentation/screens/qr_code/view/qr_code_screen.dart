import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/qr_code/controller/qr_code_controller.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final QrCodeController controller = Get.put(QrCodeController());
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();
  final GlobalKey qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load Data
  Future<void> loadData() async {
    controller.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    await controller.fetchQrCode();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CommonAppBar(title: localization.qrCodeTitle),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const CommonLoading()
                  : Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              localization.qrCodeScanTitle,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              height: 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightPrimary.withValues(alpha: 0),
                                    AppColors.lightPrimary,
                                    AppColors.lightPrimary.withValues(alpha: 0),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            RepaintBoundary(
                              key: qrKey,
                              child: SvgPicture.string(
                                controller.qrCodeModel.value.data ?? '',
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.16,
                                  ),
                                ),
                              ),
                              child: Text(
                                localization.qrCodeAccountNumber(
                                  userProfileController
                                      .userProfileModel
                                      .value
                                      .data!
                                      .user!
                                      .accountNumber!,
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.80,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            CommonButton(
                              onPressed: () => downloadQr(
                                qrKey,
                                "qr_code_${DateTime.now().millisecondsSinceEpoch}",
                              ),
                              width: double.infinity,
                              height: 54,
                              text: localization.qrCodeDownloadButton,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadQr(GlobalKey key, String fileName) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          ToastHelper().showErrorToast(
            AppLocalizations.of(Get.context!)!.qrCodePermissionError,
          );
          return;
        }
      }

      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final String path = "/storage/emulated/0/Download/$fileName.png";
      final File file = File(path);

      await file.writeAsBytes(pngBytes);
      ToastHelper().showSuccessToast(
        AppLocalizations.of(Get.context!)!.qrCodeDownloadSuccess,
      );
    } finally {}
  }
}
