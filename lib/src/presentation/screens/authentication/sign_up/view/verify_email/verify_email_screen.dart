import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/mask_email_helper.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/verify_email_controller.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final VerifyEmailController controller = Get.find();
  String? email;

  @override
  void initState() {
    super.initState();
    loadSavedEmail();
  }

  Future<void> loadSavedEmail() async {
    final savedEmail = await SettingsService.getLoggedInUserEmail();
    if (savedEmail != null && savedEmail.isNotEmpty) {
      setState(() {
        email = savedEmail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            email == null
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
                              localization.verifyEmailTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  localization.verifyEmailOtpSent,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: AppColors.lightTextPrimary
                                        .withValues(alpha: 0.30),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    MaskEmailHelper.maskEmail(email!),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                              ],
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
                                () => Column(
                                  children: [
                                    Text(
                                      controller.countdown.value > 0
                                          ? localization
                                                .verifyEmailResendCountdown(
                                                  controller.countdown.value,
                                                )
                                          : localization.verifyEmailResendReady,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.lightPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              Obx(
                                () => PinCodeTextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.lightPrimary,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: AppColors.lightTextPrimary,
                                    letterSpacing: 0,
                                  ),
                                  controller: controller.pinCodeController,
                                  enableActiveFill:
                                      controller.isPinEnabled.value,
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
                                    inactiveColor: AppColors.lightTextPrimary
                                        .withValues(alpha: 0.16),
                                    inactiveFillColor: AppColors.transparent,
                                    selectedColor: AppColors.lightPrimary,
                                    selectedFillColor: AppColors.transparent,
                                    selectedBorderWidth: 1,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  appContext: context,
                                  length: 6,
                                ),
                              ),
                              const SizedBox(height: 30),
                              CommonButton(
                                text: localization.verifyEmailContinueButton,
                                onPressed: () async {
                                  if (controller
                                          .pinCodeController
                                          .text
                                          .length ==
                                      6) {
                                    await controller.validateVerifyEmail(
                                      email: email!,
                                    );
                                  } else {
                                    ToastHelper().showErrorToast(
                                      localization.verifyEmailOtpRequired,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              CommonButton(
                                text: localization.verifyEmailBackButton,
                                onPressed: () => Get.back(),
                                backgroundColor: AppColors.lightPrimary
                                    .withValues(alpha: 0.16),
                                textColor: AppColors.lightTextPrimary,
                              ),
                              SizedBox(height: 30),
                              Wrap(
                                children: [
                                  Text(
                                    localization.verifyEmailDidntReceive,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.30),
                                    ),
                                  ),
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () => controller.sendVerifyEmail(
                                        email: email!,
                                      ),
                                      child: Text(
                                        localization.verifyEmailResend,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color:
                                              controller.isPinEnabled.value ==
                                                  true
                                              ? AppColors.lightTextPrimary
                                                    .withValues(alpha: 0.30)
                                              : AppColors.lightPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
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
      ),
    );
  }
}
