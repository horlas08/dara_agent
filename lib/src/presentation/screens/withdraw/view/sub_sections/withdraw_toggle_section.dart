import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';

class WithdrawToggleSection extends StatelessWidget {
  const WithdrawToggleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawController controller = Get.find();
    final localization = AppLocalizations.of(context)!;
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: CommonButton(
                text: localization.withdrawToggleWithdraw,
                height: 48,
                backgroundColor: controller.selectedScreen.value == 0
                    ? AppColors.lightPrimary
                    : AppColors.lightPrimary.withValues(alpha: 0.16),
                textColor: controller.selectedScreen.value == 0
                    ? AppColors.white
                    : AppColors.lightTextPrimary.withValues(alpha: 0.80),
                onPressed: () {
                  controller.clearFields();
                  controller.selectedScreen.value = 0;
                },
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: CommonButton(
                text: localization.withdrawToggleAccount,
                height: 48,
                backgroundColor: controller.selectedScreen.value == 1
                    ? AppColors.lightPrimary
                    : AppColors.lightPrimary.withValues(alpha: 0.16),
                textColor: controller.selectedScreen.value == 1
                    ? AppColors.white
                    : AppColors.lightTextPrimary.withValues(alpha: 0.80),
                onPressed: () {
                  controller.selectedScreen.value = 1;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
