import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/profit_history/controller/profit_history_controller.dart';

class ProfitHistoryFilterBottomSheet extends StatefulWidget {
  const ProfitHistoryFilterBottomSheet({super.key});

  @override
  State<ProfitHistoryFilterBottomSheet> createState() =>
      _ProfitHistoryFilterBottomSheetState();
}

class _ProfitHistoryFilterBottomSheetState
    extends State<ProfitHistoryFilterBottomSheet> {
  final ProfitHistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      height: 250,
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
              const SizedBox(height: 20),
              CommonTextInputField(
                hintText: localization.profitHistoryFilterTransactionIdHint,
                controller: controller.transactionIdController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 40),
              CommonButton(
                onPressed: () {
                  controller.isFilter.value = true;
                  controller.fetchDynamicTransactions();
                  Get.back();
                },
                width: double.infinity,
                height: 54,
                text: localization.profitHistoryFilterSearchButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
