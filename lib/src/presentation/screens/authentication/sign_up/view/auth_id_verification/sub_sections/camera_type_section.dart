import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/auth_id_verification_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/model/agent_kyc_model.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/view/auth_id_verification/sub_sections/back_camera_capture.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/view/auth_id_verification/sub_sections/kyc_submission_section.dart';

class CameraTypeSection extends StatelessWidget {
  final Fields field;

  const CameraTypeSection({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final AuthIdVerificationController controller = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(PngAssets.authTopShape),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              alignment: Alignment.centerRight,
              PngAssets.authRightSideShape,
              width: 250,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(PngAssets.appLogo, width: 80),
                  const SizedBox(height: 20),
                  Text(
                    field.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 2,
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
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      field.instructions ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: AppColors.lightTextTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      Center(
                        child: Image.asset(
                          PngAssets.cameraBackSideImage,
                          width: ScreenUtil().screenWidth * 0.70,
                        ),
                      ),
                      SizedBox(height: 80),
                      GestureDetector(
                        onTap: () async {
                          final file = await Get.to(
                            () =>
                                BackCameraCapture(fieldName: field.name ?? ""),
                          );
                          if (file != null) {
                            controller.fieldFiles[field.name ?? ""] = file;
                            Get.to(() => const KycSubmissionSection());
                          }
                        },
                        child: Image.asset(
                          PngAssets.idVerificationCameraIcon,
                          width: 80,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
