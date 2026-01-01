import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class AddMoneySuccessStepSection extends StatefulWidget {
  const AddMoneySuccessStepSection({super.key});

  @override
  State<AddMoneySuccessStepSection> createState() =>
      _AddMoneySuccessStepSectionState();
}

class _AddMoneySuccessStepSectionState
    extends State<AddMoneySuccessStepSection> {
  final AddMoneyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.currencyCode.value,
      siteCurrencyCode: Get.find<SettingsService>().getSetting(
        "site_currency",
      )!,
      siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: controller.isCrypto.value,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(PngAssets.successImage, width: 130),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    localization.addMoneySuccessTitle,
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
                    localization.addMoneySuccessDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSuccessDynamicContent(
                    title: localization.addMoneySuccessAmount,
                    content:
                        "${double.tryParse(controller.amountController.text)?.toStringAsFixed(calculateDecimals)} ${controller.successPaymentData.value!["pay_currency"]}",
                    contentColor: AppColors.lightTextPrimary,
                  ),
                  const SizedBox(height: 20),
                  _buildSuccessDynamicContent(
                    title: localization.addMoneySuccessTransactionId,
                    content: controller.successPaymentData.value!["tnx"],
                    contentColor: AppColors.lightTextPrimary,
                  ),
                  const SizedBox(height: 20),
                  _buildSuccessDynamicContent(
                    title: localization.addMoneySuccessCharge,
                    content:
                        "${double.tryParse(controller.successPaymentData.value!["charge"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successPaymentData.value!["pay_currency"]}",
                    contentColor: AppColors.error,
                  ),
                  const SizedBox(height: 20),
                  _buildSuccessDynamicContent(
                    title: localization.addMoneySuccessType,
                    content: controller.successPaymentData.value!["type"],
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
                    title: localization.addMoneySuccessFinalAmount,
                    content:
                        "${double.tryParse(controller.successPaymentData.value!["amount"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successPaymentData.value!["pay_currency"]}",
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
                    text: localization.addMoneySuccessBackHome,
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
                    text: localization.addMoneySuccessAgain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
