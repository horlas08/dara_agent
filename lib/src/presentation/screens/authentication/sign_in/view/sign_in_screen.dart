import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/biometric_auth_service.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_alert_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_auth_text_input_field.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_in/controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.bottomSheet(
          CommonAlertBottomSheet(
            title: localization.commonAlertExitTitle,
            message: localization.commonAlertExitMessage,
            onConfirm: () => exit(0),
            onCancel: () => Get.back(),
          ),
        );
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(PngAssets.appLogo, width: 80),
                    const SizedBox(height: 20),
                    Text(
                      localization.signInTitle,
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
                      AutofillGroup(
                        child: Column(
                          children: [
                            CommonAuthTextInputField(
                              hintText: localization.signInEmailHint,
                              autofillHints: const [AutofillHints.email],
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      PngAssets.commonAuthEmailIcon,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.80),
                                      width: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      height: 16,
                                      width: 2,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => CommonAuthTextInputField(
                                hintText: localization.signInPasswordHint,
                                autofillHints: const [AutofillHints.password],
                                controller: controller.passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: controller.isPasswordVisible.value,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 10,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        PngAssets.commonAuthLockIcon,
                                        color: AppColors.lightTextPrimary
                                            .withValues(alpha: 0.80),
                                        width: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 16,
                                        width: 2,
                                        color: AppColors.lightTextPrimary
                                            .withValues(alpha: 0.20),
                                      ),
                                    ],
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      controller.isPasswordVisible.toggle(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 16,
                                    ),
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(BaseRoute.forgotPassword),
                          child: Text(
                            localization.signInForgotPassword,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.lightPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CommonButton(
                        text: localization.signInLoginButton,
                        onPressed: () async {
                          if (controller.emailController.text.isEmpty) {
                            ToastHelper().showErrorToast(
                              localization.signInEmailFieldRequired,
                            );
                          } else if (controller
                              .passwordController
                              .text
                              .isEmpty) {
                            ToastHelper().showErrorToast(
                              localization.signInPasswordRequired,
                            );
                          } else {
                            await controller.submitSignIn();
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.signInNoAccount,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.30,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(BaseRoute.email),
                            child: Text(
                              localization.signInCreateAccount,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.lightPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                      GestureDetector(
                        onTap: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );

                          final savedEmail =
                              await SettingsService.getLoggedInUserEmail();
                          final savedPassword =
                              await SettingsService.getLoggedInUserPassword();

                          if (savedEmail == null || savedPassword == null) {
                            ToastHelper().showErrorToast(
                              localization.signInBiometricPrompt,
                            );

                            return;
                          }

                          if (!controller.isBiometricEnable.value) {
                            ToastHelper().showErrorToast(
                              localization.signInBiometricNotEnabled,
                            );

                            return;
                          }

                          final bioAuth = BiometricAuthService();
                          bool success = await bioAuth
                              .authenticateWithBiometrics();

                          if (success) {
                            controller.biometricEmail.value = savedEmail;
                            controller.biometricPassword.value = savedPassword;
                            await controller.submitSignIn(useBiometric: true);
                          }
                        },
                        child: Image.asset(
                          PngAssets.commonBiometricIcon,
                          width: 60,
                          height: 60,
                        ),
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
      ),
    );
  }
}
