import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/controller/cash_in_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/view/sub_sections/cash_in_amount_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/view/sub_sections/cash_in_review_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/view/sub_sections/cash_in_success_step_section.dart';

class CashInScreen extends StatefulWidget {
  const CashInScreen({super.key});

  @override
  State<CashInScreen> createState() => _CashInScreenState();
}

class _CashInScreenState extends State<CashInScreen> {
  final CashInController controller = Get.find();
  final String uidAccount = Get.arguments?['uid_account'] ?? '';

  @override
  void initState() {
    super.initState();
    controller.recipientUidController.text = uidAccount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadData();
    });
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchCashInWallets();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          if (controller.currentStep.value == 2) {
            Get.delete<CashInController>();
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
                      title: AppLocalizations.of(context)!.cashInScreenTitle,
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
                        ? CashInAmountStepSection()
                        : controller.currentStep.value == 1
                        ? CashInReviewStepSection()
                        : controller.currentStep.value == 2
                        ? CashInSuccessStepSection()
                        : SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.isCashInLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
