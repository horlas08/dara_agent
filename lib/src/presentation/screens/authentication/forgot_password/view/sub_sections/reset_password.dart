import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_auth_text_input_field.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/forgot_password/controller/reset_password_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final String email = Get.arguments?['email'] ?? '';
    final String otp = Get.arguments?['otp'] ?? '';

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
                    localization.resetPasswordTitle,
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
                    Obx(
                      () => CommonAuthTextInputField(
                        hintText: localization.resetPasswordHint,
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: controller.isPasswordVisible.value,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                PngAssets.commonAuthLockIcon,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.80,
                                ),
                                width: 20,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 16,
                                width: 2,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => controller.isPasswordVisible.toggle(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 16),
                            child: Image.asset(
                              controller.isPasswordVisible.value
                                  ? PngAssets.eyeCommonIcon
                                  : PngAssets.eyeHideCommonIcon,
                              color: AppColors.lightTextPrimary,
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CommonAuthTextInputField(
                        hintText: localization.resetPasswordConfirmHint,
                        controller: controller.confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: controller.isConfirmPasswordVisible.value,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                PngAssets.commonAuthLockIcon,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.80,
                                ),
                                width: 20,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 16,
                                width: 2,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              controller.isConfirmPasswordVisible.toggle(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 16),
                            child: Image.asset(
                              controller.isConfirmPasswordVisible.value
                                  ? PngAssets.eyeCommonIcon
                                  : PngAssets.eyeHideCommonIcon,
                              color: AppColors.lightTextPrimary,
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CommonButton(
                      text: localization.resetPasswordButton,
                      onPressed: () async {
                        if (controller.passwordController.text.isEmpty) {
                          ToastHelper().showErrorToast(
                            localization.resetPasswordRequired,
                          );
                          return;
                        } else if (controller
                                .passwordController
                                .text
                                .isNotEmpty &&
                            controller.passwordController.text.length < 8) {
                          ToastHelper().showErrorToast(
                            localization.resetPasswordMinLength,
                          );
                          return;
                        } else if (controller
                            .confirmPasswordController
                            .text
                            .isEmpty) {
                          ToastHelper().showErrorToast(
                            localization.resetPasswordConfirmRequired,
                          );
                          return;
                        } else if (controller.passwordController.text !=
                            controller.confirmPasswordController.text) {
                          ToastHelper().showErrorToast(
                            localization.resetPasswordMismatch,
                          );
                          return;
                        } else {
                          await controller.submitResetPassword(
                            email: email,
                            otp: otp,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonButton(
                      text: localization.resetPasswordBackButton,
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
