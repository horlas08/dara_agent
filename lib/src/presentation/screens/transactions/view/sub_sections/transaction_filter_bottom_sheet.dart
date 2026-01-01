import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/controller/transactions_controller.dart';

class TransactionFilterBottomSheet extends StatefulWidget {
  const TransactionFilterBottomSheet({super.key});

  @override
  State<TransactionFilterBottomSheet> createState() =>
      _TransactionFilterBottomSheetState();
}

class _TransactionFilterBottomSheetState
    extends State<TransactionFilterBottomSheet> {
  final TransactionsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      height: 300,
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
                hintText: localization.transactionFilterTransactionIdHint,
                controller: controller.transactionIdController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 38,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemCount = controller.statusList.length;
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
                          child: Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(itemCount, (index) {
                                final status = controller.statusList[index];
                                final isSelected =
                                    controller.selectedStatusIndex.value ==
                                    index;

                                return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    if (controller.selectedStatusIndex.value ==
                                        index) {
                                      controller.selectedStatusIndex.value = -1;
                                    } else {
                                      controller.selectedStatusIndex.value =
                                          index;
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: isSelected
                                          ? AppColors.lightPrimary
                                          : AppColors.lightTextPrimary
                                                .withValues(alpha: 0.06),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontSize: 14,
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.lightTextPrimary
                                                  .withValues(alpha: 0.30),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              CommonButton(
                onPressed: () {
                  controller.updateStatusFilter();
                  controller.isFilter.value = true;
                  controller.fetchDynamicTransactions();
                  Get.back();
                },
                width: double.infinity,
                height: 54,
                text: localization.transactionFilterSearchButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
