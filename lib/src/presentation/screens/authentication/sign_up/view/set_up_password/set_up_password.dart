import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_auth_text_input_field.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/set_up_password_controller.dart';
import 'package:qunzo_agent/src/presentation/widgets/web_view_dynamic.dart';

class SetUpPasswordScreen extends StatefulWidget {
  const SetUpPasswordScreen({super.key});

  @override
  State<SetUpPasswordScreen> createState() => _SetUpPasswordScreenState();
}

class _SetUpPasswordScreenState extends State<SetUpPasswordScreen> {
  final SetUpPasswordController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(PngAssets.appLogo, width: 80),
                const SizedBox(height: 20),
                Text(
                  localization.setUpPasswordTitle,
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
            top: 250,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CommonAuthTextInputField(
                      isRequired: true,
                      labelText: localization.setUpPasswordLabel,
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
                      isRequired: true,
                      labelText: localization.setUpPasswordConfirmLabel,
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
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          checkColor: AppColors.white,
                          side: BorderSide(color: AppColors.lightTextTertiary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: AppColors.lightPrimary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: controller.isTermsAndConditionChecked.value,
                          onChanged: (bool? value) {
                            Future.microtask(() {
                              controller.isTermsAndConditionChecked.value =
                                  value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.isTermsAndConditionChecked.value =
                                  !controller.isTermsAndConditionChecked.value;
                            },
                            child: Text(
                              localization.setUpPasswordAgreeTerms,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0,
                                fontSize: 15,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => WebViewDynamic(
                                  dynamicUrl:
                                      "${ApiPath.baseUrl}${ApiPath.termsAndConditionsEndpoint}",
                                ),
                              );
                            },
                            child: Text(
                              localization.setUpPasswordTermsConditions,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.lightPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CommonButton(
                    text: localization.setUpPasswordButton,
                    onPressed: () async {
                      if (controller.passwordController.text.isEmpty) {
                        ToastHelper().showErrorToast(
                          localization.setUpPasswordRequired,
                        );
                      } else if (controller
                              .passwordController
                              .text
                              .isNotEmpty &&
                          controller.passwordController.text.length < 8) {
                        ToastHelper().showErrorToast(
                          localization.setUpPasswordMinLength,
                        );
                      } else if (controller
                          .confirmPasswordController
                          .text
                          .isEmpty) {
                        ToastHelper().showErrorToast(
                          localization.setUpPasswordConfirmRequired,
                        );
                      } else if (controller.passwordController.text !=
                          controller.confirmPasswordController.text) {
                        ToastHelper().showErrorToast(
                          localization.setUpPasswordMismatch,
                        );
                      } else if (!controller.isTermsAndConditionChecked.value) {
                        ToastHelper().showErrorToast(
                          localization.setUpPasswordAcceptTerms,
                        );
                      } else {
                        controller.setUpPassword();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CommonButton(
                    text: localization.setUpPasswordBackButton,
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
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
