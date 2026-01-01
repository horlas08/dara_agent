import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/controller/cash_in_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class CashInSuccessStepSection extends StatefulWidget {
  const CashInSuccessStepSection({super.key});

  @override
  State<CashInSuccessStepSection> createState() =>
      _CashInSuccessStepSectionState();
}

class _CashInSuccessStepSectionState extends State<CashInSuccessStepSection> {
  final CashInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Obx(() {
      final data = controller.successCashInData.value;
      if (data == null) {
        return const CommonLoading();
      }

      final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
        currencyCode: data["currency"],
        siteCurrencyCode: Get.find<SettingsService>().getSetting(
          "site_currency",
        )!,
        siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
          "site_currency_decimals",
        )!,
        isCrypto: data["is_crypto"],
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
                      localization.cashInSuccessTitle,
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
                      localization.cashInSuccessDescription,
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
                      title: localization.cashInSuccessAmount,
                      content:
                          "${double.tryParse(controller.amountController.text)?.toStringAsFixed(calculateDecimals)} ${data["currency"]}",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.cashInSuccessTransactionId,
                      content: data["tnx"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.cashInSuccessWalletName,
                      content: data["wallet_name"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.cashInSuccessAccountNumber,
                      content: data["user"]["account_number"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.cashInSuccessCharge,
                      content:
                          "${double.tryParse(data["charge"].toString())!.toStringAsFixed(calculateDecimals)} ${data["currency"]}",
                      contentColor: AppColors.error,
                    ),
                    const SizedBox(height: 20),
                    _buildSuccessDynamicContent(
                      title: localization.cashInSuccessType,
                      content: data["type"],
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
                      title: localization.cashInSuccessFinalAmount,
                      content:
                          "${double.tryParse(data["final_amount"].toString())!.toStringAsFixed(calculateDecimals)} ${data["currency"]}",
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
                        Get.delete<CashInController>();
                        Get.offNamed(BaseRoute.navigation);
                        await Get.find<HomeController>().loadData();
                      },
                      textColor: AppColors.lightTextPrimary,
                      text: localization.cashInSuccessBackHome,
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
                        await controller.fetchCashInWallets();
                        controller.isLoading.value = false;
                      },
                      text: localization.cashInSuccessAgain,
                    ),
                  ),
                ],
              ),
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
