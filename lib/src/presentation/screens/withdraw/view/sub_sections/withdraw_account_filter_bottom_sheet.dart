import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';

class WithdrawAccountFilterBottomSheet extends StatefulWidget {
  const WithdrawAccountFilterBottomSheet({super.key});

  @override
  State<WithdrawAccountFilterBottomSheet> createState() =>
      _WithdrawAccountFilterBottomSheetState();
}

class _WithdrawAccountFilterBottomSheetState
    extends State<WithdrawAccountFilterBottomSheet> {
  final WithdrawAccountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      height: 260,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(height: 30),
              CommonTextInputField(
                hintText: localization.withdrawAccountFilterAccountNameHint,
                controller: controller.methodNameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CommonButton(
                onPressed: () {
                  controller.fetchDynamicWithdrawAccounts();
                  controller.methodNameController.clear();
                  Get.back();
                },
                width: double.infinity,
                height: 54,
                text: localization.withdrawAccountFilterSearchButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
