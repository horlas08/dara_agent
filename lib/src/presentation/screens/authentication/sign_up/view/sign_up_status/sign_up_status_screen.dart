import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/svg_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_alert_bottom_sheet.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/sign_up_status_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/view/auth_id_verification/sub_sections/submit_valid_id_verification.dart';

class SignUpStatusScreen extends StatefulWidget {
  const SignUpStatusScreen({super.key});

  @override
  State<SignUpStatusScreen> createState() => _SignUpStatusScreenState();
}

class _SignUpStatusScreenState extends State<SignUpStatusScreen> {
  final SignUpStatusController controller = Get.find();
  final bool isPasswordSetup = Get.arguments?["is_password_set_up"] ?? false;
  final bool isPersonalInfo = Get.arguments?["is_personal_info"] ?? false;
  final bool isIdVerification = Get.arguments?["is_id_verification"] ?? false;
  final bool isLogInState = Get.arguments?["is_login_state"] ?? false;
  final RxBool emailVerified = false.obs;
  final RxBool setUpPassword = false.obs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadEmailVerified();
    await loadSetUpPassword();
    if (isPasswordSetup || isPersonalInfo || isIdVerification || isLogInState) {
      await controller.fetchUser();
    }
  }

  // Load Email Verified for current user
  Future<void> loadEmailVerified() async {
    final isEmailVerified = await SettingsService.getEmailVerified();
    if (isEmailVerified != null) {
      emailVerified.value = isEmailVerified;
    }
  }

  // Load Set Up Password for current user
  Future<void> loadSetUpPassword() async {
    final isSetUpPassword = await SettingsService.getSetUpPassword();
    if (isSetUpPassword != null) {
      setUpPassword.value = isSetUpPassword;
    }
  }

  // Check if all steps are completed
  bool get allStepsCompleted {
    final personalInfoCompleted =
        controller.userModel.value.data?.user!.boardingSteps?.personalInfo ==
        true;
    final idVerificationCompleted =
        controller.userModel.value.data?.user!.boardingSteps?.idVerification ==
        false;
    final isKycVerification = controller.userModel.value.data?.user!.kyc == 2;

    return getEmailVerificationStatus() &&
        getPasswordSetupStatus() &&
        personalInfoCompleted &&
        idVerificationCompleted &&
        isKycVerification;
  }

  // Get current status
  bool getEmailVerificationStatus() {
    if (isLogInState || isPersonalInfo || isIdVerification) {
      return controller
              .userModel
              .value
              .data
              ?.user!
              .boardingSteps
              ?.emailVerification ==
          true;
    } else {
      return emailVerified.value;
    }
  }

  bool getPasswordSetupStatus() {
    if (isLogInState || isPersonalInfo || isIdVerification) {
      return controller
              .userModel
              .value
              .data
              ?.user!
              .boardingSteps
              ?.passwordSetup ==
          true;
    } else {
      return setUpPassword.value;
    }
  }

  // Get ID verification
  String? get idVerificationStatusText {
    final idVerification =
        controller.userModel.value.data?.user!.boardingSteps?.idVerification;
    final kycVerification = controller.userModel.value.data?.user!.kyc;
    return (idVerification == false && kycVerification == 2)
        ? AppLocalizations.of(context)!.signUpStatusInReview
        : (idVerification == false && kycVerification == 3)
        ? AppLocalizations.of(context)!.signUpStatusRejected
        : null;
  }

  // Next Step
  Future<void> _handleNextStep() async {
    try {
      final emailVerificationDone = getEmailVerificationStatus();
      final passwordSetupDone = getPasswordSetupStatus();
      final personalInfoDone =
          controller.userModel.value.data?.user!.boardingSteps?.personalInfo ==
          true;
      final kycStatus = controller.userModel.value.data?.user!.kyc;

      if (emailVerificationDone &&
          passwordSetupDone &&
          personalInfoDone &&
          kycStatus == 3) {
        Get.to(() => SubmitValidIdVerification());
      } else if (emailVerificationDone &&
          passwordSetupDone &&
          personalInfoDone) {
        Get.to(() => SubmitValidIdVerification());
      } else if (emailVerificationDone && passwordSetupDone) {
        Get.toNamed(BaseRoute.personalInfo);
      } else if (emailVerificationDone) {
        Get.toNamed(BaseRoute.setUpPassword);
      }
    } catch (e) {
      ToastHelper().showErrorToast(
        AppLocalizations.of(context)!.signUpStatusErrorProcessing,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        showExitApplicationAlertDialog();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return CommonLoading();
              }

              return RefreshIndicator(
                color: AppColors.lightPrimary,
                onRefresh: () async {
                  controller.isLoading.value = true;
                  await controller.fetchUser();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(PngAssets.appLogo, width: 80),
                            const SizedBox(height: 20),
                            Text(
                              localization.signUpStatusTitle,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Text(
                                localization.signUpStatusSubtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                  color: AppColors.lightTextPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            _buildMainContent(context),
                            const SizedBox(height: 40),
                            _buildActionButton(context),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Obx(
              () => Visibility(
                visible: controller.isFcmTokenLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildStep(
              step: 1,
              title: localization.signUpStatusEmailVerification,
              isCompleted: getEmailVerificationStatus(),
              icon: SvgAssets.commonEmailVerification,
            ),
            _buildStep(
              step: 2,
              title: localization.signUpStatusSetupPassword,
              isCompleted: getPasswordSetupStatus(),
              icon: SvgAssets.commonSetUpPassword,
            ),
            _buildStep(
              step: 3,
              title: localization.signUpStatusPersonalInfo,
              isCompleted:
                  controller
                      .userModel
                      .value
                      .data
                      ?.user!
                      .boardingSteps
                      ?.personalInfo ==
                  true,
              icon: SvgAssets.commonPersonalInfo,
            ),
            _buildStep(
              step: 4,
              title: localization.signUpStatusIdVerification,
              isCompleted:
                  controller
                      .userModel
                      .value
                      .data
                      ?.user!
                      .boardingSteps
                      ?.idVerification ==
                  true,
              icon: SvgAssets.commonIdVerification,
              statusText: idVerificationStatusText,
              statusColor: AppColors.warning,
            ),
            if (controller.userModel.value.data?.user?.kyc == 3)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  (controller
                                  .userModel
                                  .value
                                  .data
                                  ?.user
                                  ?.agent
                                  ?.rejectionReason !=
                              null &&
                          controller
                                  .userModel
                                  .value
                                  .data
                                  ?.user
                                  ?.agent
                                  ?.rejectionReason
                                  ?.trim()
                                  .isNotEmpty ==
                              true)
                      ? controller
                                .userModel
                                .value
                                .data!
                                .user!
                                .agent!
                                .rejectionReason ??
                            ""
                      : localization.signUpStatusNoReason,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 13,
                    color: AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  Widget _buildActionButton(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Obx(() {
      final userData = controller.userModel.value.data;
      final boardingSteps = userData?.user!.boardingSteps;
      final isCompleted = boardingSteps?.completed ?? false;
      final isPersonalInfo = boardingSteps?.personalInfo ?? false;
      final isReview = controller.userModel.value.data?.user?.kyc == 2;
      final isRejected = controller.userModel.value.data?.user?.kyc == 3;

      return Column(
        children: [
          if (!allStepsCompleted && !isCompleted)
            Obx(
              () => CommonButton(
                onPressed: _handleNextStep,
                width: double.infinity,
                text: controller.userModel.value.data?.user?.kyc == 3
                    ? localization.signUpStatusSubmitAgain
                    : localization.signUpStatusNextButton,
              ),
            ),

          if (isCompleted)
            CommonButton(
              onPressed: () => controller.postFcmNotification(),
              width: double.infinity,
              height: 54,
              text: localization.signUpStatusDashboard,
            ),

          if (isPersonalInfo && !(isReview || isRejected || isCompleted)) ...[
            SizedBox(height: 15),
            CommonButton(
              text: localization.signUpStatusBackButton,
              onPressed: () {
                Get.toNamed(
                  BaseRoute.personalInfo,
                  arguments: {"is_personal_info_edit": true},
                );
              },
              backgroundColor: AppColors.lightPrimary.withValues(alpha: 0.16),
              textColor: AppColors.lightTextPrimary,
            ),
          ],
        ],
      );
    });
  }

  Widget _buildStep({
    required int step,
    required String title,
    required bool isCompleted,
    required String icon,
    String? statusText,
    Color? statusColor,
  }) {
    final bool isActive = isCompleted;
    final bool isIdVerificationInReview =
        step == 4 &&
        controller.userModel.value.data?.user?.boardingSteps?.idVerification ==
            false &&
        (controller.userModel.value.data?.user?.kyc == 2);
    final bool isIdVerificationRejected =
        step == 4 &&
        controller.userModel.value.data?.user?.boardingSteps?.idVerification ==
            false &&
        (controller.userModel.value.data?.user?.kyc == 3);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isIdVerificationInReview
            ? AppColors.warning.withValues(alpha: 0.06)
            : isIdVerificationRejected
            ? AppColors.error.withValues(alpha: 0.06)
            : isActive
            ? AppColors.success.withValues(alpha: 0.06)
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isIdVerificationInReview
              ? AppColors.warning
              : isIdVerificationRejected
              ? AppColors.error
              : isActive
              ? AppColors.success
              : AppColors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isIdVerificationInReview
                      ? AppColors.warning
                      : isIdVerificationRejected
                      ? AppColors.error
                      : isActive
                      ? AppColors.lightPrimary
                      : AppColors.lightTextPrimary.withValues(alpha: 0.06),
                ),
                child: Center(
                  child: isCompleted
                      ? SvgPicture.asset(
                          icon,
                          width: 22,
                          height: 22,
                          colorFilter: ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          icon,
                          width: 22,
                          height: 22,
                          colorFilter: ColorFilter.mode(
                            isIdVerificationInReview
                                ? AppColors.white
                                : isIdVerificationRejected
                                ? AppColors.white
                                : AppColors.lightTextPrimary.withValues(
                                    alpha: 0.40,
                                  ),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: isCompleted
                      ? AppColors.lightTextPrimary
                      : AppColors.lightTextPrimary.withValues(alpha: 0.60),
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          if (isCompleted)
            Image.asset(PngAssets.stepperCheckCommonIcon, width: 35),
          if (statusText != null) ...[
            Text(
              statusText,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: isIdVerificationInReview
                    ? AppColors.warning
                    : AppColors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void showExitApplicationAlertDialog() {
    Get.bottomSheet(
      CommonAlertBottomSheet(
        title: AppLocalizations.of(context)!.commonAlertExitTitle,
        message: AppLocalizations.of(context)!.commonAlertExitMessage,
        onConfirm: () async {
          await Get.find<TokenService>().clearToken();
          exit(0);
        },
        onCancel: () => Get.back(),
      ),
    );
  }
}
