import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/two_factor_auth/controller/two_factor_auth_controller.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  final TwoFactorAuthController controller =
      Get.find<TwoFactorAuthController>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(PngAssets.appLogo, width: 80),
                  const SizedBox(height: 20),
                  Text(
                    localization.twoFactorAuthTitle,
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
                ],
              ),
            ),
            Positioned.fill(
              top: 270,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.lightPrimary,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: AppColors.lightTextPrimary,
                        letterSpacing: 0,
                      ),
                      controller: controller.pinCodeController,
                      pinTheme: PinTheme(
                        borderWidth: 1,
                        activeBorderWidth: 1,
                        disabledBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 52,
                        fieldWidth: 52,
                        activeColor: AppColors.lightPrimary,
                        activeFillColor: AppColors.transparent,
                        inactiveColor: AppColors.lightTextPrimary.withValues(
                          alpha: 0.16,
                        ),
                        inactiveFillColor: AppColors.transparent,
                        selectedColor: AppColors.lightPrimary,
                        selectedFillColor: AppColors.transparent,
                        disabledColor: AppColors.lightTextPrimary.withValues(
                          alpha: 0.05,
                        ),
                        selectedBorderWidth: 1,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      appContext: context,
                      length: 6,
                    ),
                    const SizedBox(height: 30),
                    CommonButton(
                      text: localization.twoFactorAuthVerifyButton,
                      onPressed: () async {
                        if (controller.pinCodeController.text.length == 6) {
                          await controller.submitTwoFaVerification();
                        } else {
                          ToastHelper().showErrorToast(
                            localization.twoFactorAuthOtpRequired,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonButton(
                      text: localization.twoFactorAuthBackButton,
                      onPressed: () => Get.back(),
                      backgroundColor: AppColors.lightPrimary.withValues(
                        alpha: 0.16,
                      ),
                      textColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: const CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
