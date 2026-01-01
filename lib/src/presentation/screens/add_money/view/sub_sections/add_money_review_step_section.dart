import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';

class AddMoneyReviewStepSection extends StatelessWidget {
  const AddMoneyReviewStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMoneyController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              localization.addMoneyReviewTitle,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                fontSize: 20,
                color: AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                ),
              ),
              child: Column(
                children: [
                  _buildReviewDynamicContent(
                    context,
                    title: localization.addMoneyReviewAmount,
                    content:
                        "${controller.baseAmount.value.toStringAsFixed(controller.currencyDecimals.value)} ${controller.currencyCode.value}",
                    contentColor: AppColors.success,
                  ),
                  const SizedBox(height: 20),
                  _buildReviewDynamicContent(
                    context,
                    title: localization.addMoneyReviewWalletName,
                    content: controller.wallet.value,
                    contentColor: AppColors.black,
                  ),
                  const SizedBox(height: 20),
                  _buildReviewDynamicContent(
                    context,
                    title: localization.addMoneyReviewPaymentMethod,
                    content: controller.gateway.value,
                    contentColor: AppColors.black,
                  ),
                  const SizedBox(height: 20),
                  _buildReviewDynamicContent(
                    context,
                    title: localization.addMoneyReviewCharge,
                    content:
                        "${controller.calculatedCharge.value.toStringAsFixed(controller.gatewayCurrencyType.value != "crypto" ? 2 : controller.currencyDecimals.value)} ${controller.currencyCode.value}",
                    contentColor: AppColors.error,
                  ),
                  if (controller.dynamicFieldControllers.isNotEmpty)
                    ..._buildDynamicFieldsReview(context, controller),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lightPrimary.withValues(alpha: 0),
                          AppColors.lightPrimary,
                          AppColors.lightPrimary.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildReviewDynamicContent(
                    context,
                    title: localization.addMoneyReviewTotal,
                    content:
                        "${controller.totalAmount.value.toStringAsFixed(controller.currencyDecimals.value)} ${controller.currencyCode.value}",
                    contentColor: AppColors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CommonButton(
              text: localization.addMoneyReviewAddMoneyButton,
              onPressed: () {
                if (controller.gatewayType.value == "auto") {
                  controller.submitAddMoneyAuto();
                } else {
                  controller.submitAddMoneyManual();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic fields review section
  List<Widget> _buildDynamicFieldsReview(
    BuildContext context,
    AddMoneyController controller,
  ) {
    List<Widget> widgets = [];
    final fields = controller.dynamicFieldControllers.entries.toList();

    for (int i = 0; i < fields.length; i++) {
      final entry = fields[i];
      final fieldName = entry.key;
      final fieldData = entry.value;
      final textController = fieldData['controller'] as TextEditingController;
      final type = fieldData['type'] as String;

      widgets.add(const SizedBox(height: 20));

      if (type == 'file') {
        final file = controller.selectedImages[fieldName];
        final fileName = file?.path.split('/').last ?? '...';

        widgets.add(
          _buildReviewDynamicContent(
            context,
            title: fieldName,
            content: fileName,
            contentColor: AppColors.black,
          ),
        );
      } else {
        widgets.add(
          _buildReviewDynamicContent(
            context,
            title: fieldName,
            content: textController.text.isNotEmpty
                ? textController.text
                : "...",
            contentColor: AppColors.black,
          ),
        );
      }
    }

    return widgets;
  }

  static Widget _buildReviewDynamicContent(
    context, {
    required String title,
    required String content,
    required Color contentColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.lightTextTertiary,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: contentColor,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
