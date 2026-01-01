import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class AddMoneyPendingStepSection extends StatefulWidget {
  const AddMoneyPendingStepSection({super.key});

  @override
  State<AddMoneyPendingStepSection> createState() =>
      _AddMoneyPendingStepSectionState();
}

class _AddMoneyPendingStepSectionState
    extends State<AddMoneyPendingStepSection> {
  final AddMoneyController controller = Get.find();
  double totalAmount = 0.0;
  bool isCalculated = false;

  double parseToDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  void totalCalculate(Map<String, dynamic> transaction) {
    double amount = parseToDouble(transaction["amount"]);
    double charge = parseToDouble(transaction["charge"]);
    totalAmount = amount + charge;
    isCalculated = true;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Obx(() {
      final data = controller.pendingPaymentData.value;

      if (data == null || data["transaction"] == null) {
        return const CommonLoading();
      }

      final transaction = data["transaction"];
      final payCurrency = transaction["pay_currency"];

      if (!isCalculated) {
        totalCalculate(transaction);
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(PngAssets.pendingImage, width: 130),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      localization.addMoneyPendingTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        color: AppColors.lightTextPrimary,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      localization.addMoneyPendingDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.30,
                        ),
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyAmount,
                      content:
                          "${double.tryParse(controller.amountController.text)?.toStringAsFixed(controller.currencyDecimals.value)} $payCurrency",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyTransactionId,
                      content: transaction["tnx"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyWalletName,
                      content: controller.wallet.value,
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyPaymentMethod,
                      content: payCurrency,
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyCharge,
                      content:
                          "${parseToDouble(transaction["charge"]).toStringAsFixed(controller.gatewayCurrencyType.value != "crypto" ? 2 : controller.currencyDecimals.value)} $payCurrency",
                      contentColor: AppColors.error,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyType,
                      content: transaction["type"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
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
                    _buildSuccessDynamicContent(
                      title: localization.addMoneyFinalAmount,
                      content:
                          "${totalAmount.toStringAsFixed(controller.currencyDecimals.value)} $payCurrency",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      onPressed: () async {
                        Get.delete<AddMoneyController>();
                        Get.offNamed(BaseRoute.navigation);
                        await Get.find<HomeController>().loadData();
                      },
                      textColor: AppColors.lightTextPrimary,
                      text: localization.addMoneyBackHome,
                      backgroundColor: AppColors.lightPrimary.withValues(
                        alpha: 0.16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CommonButton(
                      onPressed: () async {
                        controller.clearFields();
                        controller.currentStep.value = 0;
                        controller.isLoading.value = true;
                        await controller.fetchWallets();
                        controller.isLoading.value = false;
                      },
                      text: localization.addMoneyAgain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    });
  }

  static Widget _buildSuccessDynamicContent({
    required String title,
    required String content,
    required Color contentColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.lightTextTertiary,
            letterSpacing: 0,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: contentColor,
              letterSpacing: 0,
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
