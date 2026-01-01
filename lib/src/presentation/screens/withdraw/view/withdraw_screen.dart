import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_account_filter_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_account_section.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_section.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_toggle_section.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final WithdrawController controller = Get.put(WithdrawController());

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          if (controller.currentStep.value == 2) {
            Get.delete<WithdrawController>();
            Get.offNamed(BaseRoute.navigation);
          } else if (controller.currentStep.value == 1) {
            Get.delete<WithdrawController>();
            Get.back();
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: CommonDefaultAppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Obx(
                  () => controller.currentStep.value == 2
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            CommonAppBar(
                              title: localization.withdrawScreenTitle,
                              showRightSideWidget:
                                  controller.selectedScreen.value == 1
                                  ? true
                                  : false,
                              rightSideWidget: GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    WithdrawAccountFilterBottomSheet(),
                                  );
                                },
                                child: Image.asset(
                                  PngAssets.commonFilterIcon,
                                  width: 26,
                                ),
                              ),
                              isBackLogicApply: true,
                              backLogicFunction: () {
                                if (controller.currentStep.value == 0) {
                                  Get.back();
                                } else if (controller.currentStep.value == 1) {
                                  controller.currentStep.value = 0;
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.currentStep.value == 0,
                    child: WithdrawToggleSection(),
                  ),
                ),
                Obx(
                  () => controller.selectedScreen.value == 0
                      ? WithdrawSection()
                      : controller.selectedScreen.value == 1
                      ? WithdrawAccountSection()
                      : SizedBox.shrink(),
                ),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.isWithdrawLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
        floatingActionButton: Obx(() {
          return controller.selectedScreen.value == 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 46,
                    width: 150,
                    child: FloatingActionButton(
                      heroTag: null,
                      elevation: 0,
                      onPressed: () {
                        Get.toNamed(BaseRoute.createWithdrawAccount);
                      },
                      backgroundColor: AppColors.lightPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(PngAssets.addCommonIcon, width: 16),
                          const SizedBox(width: 5),
                          Text(
                            localization.withdrawScreenAddAccountButton,
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15.5,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
