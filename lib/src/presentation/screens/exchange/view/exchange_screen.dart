import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/view/sub_sections/exchange_amount_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/view/sub_sections/exchange_review_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/view/sub_sections/exchange_success_step_section.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final ExchangeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          if (controller.currentStep.value == 2) {
            Get.delete<ExchangeController>();
            Get.offNamed(BaseRoute.navigation);
          } else if (controller.currentStep.value == 1) {
            Get.delete<ExchangeController>();
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
                SizedBox(height: 16.h),
                Obx(
                  () => controller.currentStep.value == 2
                      ? SizedBox.shrink()
                      : CommonAppBar(
                          title: AppLocalizations.of(
                            context,
                          )!.exchangeScreenTitle,
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return Expanded(child: const CommonLoading());
                  }

                  return controller.currentStep.value == 0
                      ? ExchangeAmountStepSection()
                      : controller.currentStep.value == 1
                      ? ExchangeReviewStepSection()
                      : ExchangeSuccessStepSection();
                }),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.isExchangeWalletLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
