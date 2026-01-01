import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/two_fa_authentication_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/view/two_fa_authentication/sub_sections/disable_two_fa_section.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/view/two_fa_authentication/sub_sections/enable_two_fa_section.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/view/two_fa_authentication/sub_sections/generate_qr_code_section.dart';

class TwoFaAuthentication extends StatefulWidget {
  const TwoFaAuthentication({super.key});

  @override
  State<TwoFaAuthentication> createState() => _TwoFaAuthenticationState();
}

class _TwoFaAuthenticationState extends State<TwoFaAuthentication> {
  final TwoFaAuthenticationController controller = Get.find();
  final UserProfileController userProfileController = Get.find();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    if (userProfileController
            .userProfileModel
            .value
            .data!
            .user!
            .google2faSecret !=
        false) {
      await controller.getQRCode();
    }
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              CommonAppBar(
                title: AppLocalizations.of(context)!.twoFaAuthenticationTitle,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.lightPrimary,
                  onRefresh: () => loadData(),
                  child: Obx(() {
                    if (controller.isLoading.value ||
                        controller.isGenerateQRCodeLoading.value) {
                      return const CommonLoading();
                    }

                    return userProfileController
                                .userProfileModel
                                .value
                                .data!
                                .user!
                                .twoFa ==
                            true
                        ? DisableTwoFaSection()
                        : userProfileController
                                  .userProfileModel
                                  .value
                                  .data!
                                  .user!
                                  .google2faSecret ==
                              false
                        ? GenerateQrCodeSection()
                        : EnableTwoFaSection();
                  }),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible:
                  controller.isEnableTwoFaLoading.value ||
                  controller.isDisableTwoFaLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
