import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/view/sub_sections/add_money_amount_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/view/sub_sections/add_money_pending_setp_section.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/view/sub_sections/add_money_review_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/view/sub_sections/add_money_success_step_section.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final AddMoneyController controller = Get.find();
  final String walletId = Get.arguments?["wallet_id"] ?? "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      walletId.isNotEmpty
          ? controller.findWallet(walletIdQuery: walletId.toString())
          : loadData();
    });
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWallets();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          if (controller.currentStep.value == 2 ||
              controller.currentStep.value == 3) {
            Get.delete<AddMoneyController>();
            Get.offNamed(BaseRoute.navigation);
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
                  () => Visibility(
                    visible:
                        controller.currentStep.value == 0 ||
                        controller.currentStep.value == 1,
                    child: CommonAppBar(
                      title: AppLocalizations.of(context)!.addMoneyScreenTitle,
                      isBackLogicApply: true,
                      backLogicFunction: () {
                        if (controller.currentStep.value == 0) {
                          Get.back();
                        } else if (controller.currentStep.value == 1) {
                          controller.currentStep.value = 0;
                        }
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: controller.currentStep.value == 0
                        ? AddMoneyAmountStepSection()
                        : controller.currentStep.value == 1
                        ? AddMoneyReviewStepSection()
                        : controller.currentStep.value == 2
                        ? AddMoneySuccessStepSection()
                        : controller.currentStep.value == 3
                        ? AddMoneyPendingStepSection()
                        : SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            Obx(
              () => Visibility(
                visible:
                    controller.isGatewayMethodsLoading.value ||
                    controller.isPaymentLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
