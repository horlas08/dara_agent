import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_amount_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_pending_step_section.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/withdraw_review_step_section.dart';

class WithdrawSection extends StatefulWidget {
  const WithdrawSection({super.key});

  @override
  State<WithdrawSection> createState() => _WithdrawSectionState();
}

class _WithdrawSectionState extends State<WithdrawSection> {
  final WithdrawController controller = Get.find();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWithdrawAccounts();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => controller.currentStep.value == 0
            ? WithdrawAmountStepSection()
            : controller.currentStep.value == 1
            ? WithdrawReviewStepSection()
            : controller.currentStep.value == 2
            ? WithdrawPendingStepSection()
            : SizedBox.shrink(),
      ),
    );
  }
}
