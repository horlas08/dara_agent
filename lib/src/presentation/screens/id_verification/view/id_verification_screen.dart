import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/id_verification/controller/id_verification_controller.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  final IdVerificationController controller = Get.find();

  Future<void> refreshData() async {
    await controller.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CommonAppBar(
            title: localization.idVerificationTitle,
            showRightSideWidget: true,
            rightSideWidget: GestureDetector(
              onTap: () => Get.toNamed(BaseRoute.kycHistory),
              child: Text(
                localization.idVerificationHistory,
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.lightTextTertiary,
                  decorationThickness: 2,
                  color: AppColors.lightTextTertiary,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const CommonLoading();
              }

              return RefreshIndicator(
                color: AppColors.lightPrimary,
                onRefresh: () => refreshData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            _buildVerificationSection(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                          top: 16,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              localization.idVerificationCenter,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                letterSpacing: 0,
                                color: AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Divider(
                              color: AppColors.black.withValues(alpha: 0.15),
                              height: 0,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Center(
                                child: Text(
                                  localization.idVerificationNothingToSubmit,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSection() {
    final kyc = controller.userModel.value.data?.user?.kyc;
    final kycInfo = getKycStatusInfo(kyc: kyc);
    final localization = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: kycInfo.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kycInfo.color,
            ),
            child: Icon(kycInfo.icon, color: AppColors.white),
          ),
          const SizedBox(height: 7),
          Text(
            localization.idVerificationStatusVerifiedTitle,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.lightTextPrimary,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              kycInfo.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.lightTextTertiary,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KycStatusInfo {
  final Color color;
  final IconData icon;
  final String message;

  KycStatusInfo({
    required this.color,
    required this.icon,
    required this.message,
  });
}

KycStatusInfo getKycStatusInfo({required int? kyc, context}) {
  final localization = AppLocalizations.of(context)!;
  switch (kyc) {
    case 1:
      return KycStatusInfo(
        color: AppColors.success,
        icon: Icons.check_circle_outline_outlined,
        message: localization.idVerificationStatusVerifiedMessage,
      );
    case 2:
      return KycStatusInfo(
        color: AppColors.warning,
        icon: Icons.warning_amber_outlined,
        message: localization.idVerificationStatusPendingMessage,
      );
    case 3:
      return KycStatusInfo(
        color: AppColors.error,
        icon: Icons.error_outline_outlined,
        message: localization.idVerificationStatusFailedMessage,
      );
    case 4:
    default:
      return KycStatusInfo(
        color: AppColors.warning,
        icon: Icons.error_outline_outlined,
        message: localization.idVerificationStatusNotSubmittedMessage,
      );
  }
}
