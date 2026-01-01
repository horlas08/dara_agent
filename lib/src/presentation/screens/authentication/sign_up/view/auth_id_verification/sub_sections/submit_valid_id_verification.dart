import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/sign_up_status_controller.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';

class SubmitValidIdVerification extends StatefulWidget {
  const SubmitValidIdVerification({super.key});

  @override
  State<SubmitValidIdVerification> createState() =>
      _SubmitValidIdVerificationState();
}

class _SubmitValidIdVerificationState extends State<SubmitValidIdVerification> {
  final SignUpStatusController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserKyc();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Obx(
        () => controller.isKycLoading.value
            ? CommonLoading()
            : Stack(
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
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 60,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(PngAssets.appLogo, width: 80),
                          const SizedBox(height: 20),
                          Text(
                            localization.submitValidIdVerificationTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                              color: AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 60),
                          Center(
                            child: Image.asset(
                              PngAssets.authIdVerificationImage,
                              width: ScreenUtil().screenWidth * 0.70,
                            ),
                          ),
                          const SizedBox(height: 60),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              localization
                                  .submitValidIdVerificationChooseIdType,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          controller.userKycList.isEmpty
                              ? NoDataFound()
                              : ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 10,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final type = controller.userKycList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (type.fields != null) {
                                          Future.delayed(
                                            Duration(milliseconds: 200),
                                            () {
                                              Get.toNamed(
                                                BaseRoute.authIdVerification,
                                                arguments: {
                                                  "fields": type.fields,
                                                  "kyc_id": type.id.toString(),
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.04),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                type.name ?? "",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  letterSpacing: 0,
                                                  fontSize: 18,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.80),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Image.asset(
                                              PngAssets.arrowRightCommonIcon,
                                              width: 18,
                                              color:
                                                  AppColors.lightTextTertiary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 16);
                                  },
                                  itemCount: controller.userKycList.length,
                                ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
