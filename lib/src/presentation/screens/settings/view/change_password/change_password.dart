import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/change_password_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangePasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              CommonAppBar(title: localization.changePasswordTitle),
              SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Obx(
                        () => CommonTextInputField(
                          controller: controller.currentPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          hintText:
                              localization.changePasswordCurrentPasswordHint,
                          obscureText:
                              controller.isCurrentPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isCurrentPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
                              child: Image.asset(
                                controller.isCurrentPasswordVisible.value
                                    ? PngAssets.eyeCommonIcon
                                    : PngAssets.eyeHideCommonIcon,
                                color: AppColors.lightTextPrimary,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => CommonTextInputField(
                          controller: controller.newPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          hintText: localization.changePasswordNewPasswordHint,
                          obscureText: controller.isNewPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isNewPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
                              child: Image.asset(
                                controller.isNewPasswordVisible.value
                                    ? PngAssets.eyeCommonIcon
                                    : PngAssets.eyeHideCommonIcon,
                                color: AppColors.lightTextPrimary,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => CommonTextInputField(
                          controller: controller.confirmPasswordController,
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.text,
                          hintText:
                              localization.changePasswordConfirmPasswordHint,
                          obscureText:
                              controller.isConfirmPasswordVisible.value,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                controller.isConfirmPasswordVisible.toggle(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 16,
                              ),
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
                      SizedBox(height: 30),
                      CommonButton(
                        onPressed: () async {
                          if (!controller.validatePassword()) {
                            return;
                          }

                          await controller.changePassword();
                        },
                        width: double.infinity,
                        height: 54,
                        text: localization.changePasswordSaveChangesButton,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
