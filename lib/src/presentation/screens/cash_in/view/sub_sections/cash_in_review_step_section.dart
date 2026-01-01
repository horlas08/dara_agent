import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/controller/cash_in_controller.dart';

class CashInReviewStepSection extends StatefulWidget {
  const CashInReviewStepSection({super.key});

  @override
  State<CashInReviewStepSection> createState() =>
      _CashInReviewStepSectionState();
}

class _CashInReviewStepSectionState extends State<CashInReviewStepSection> {
  final CashInController controller = Get.find();
  final settingsService = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.walletCurrency.value,
      siteCurrencyCode: settingsService.getSetting("site_currency")!,
      siteCurrencyDecimals: settingsService.getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: controller.isCrypto.value,
    );

    return Obx(
      () => controller.isCashInConfigLoading.value
          ? CommonLoading()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      localization.cashInReviewTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                        fontSize: 20,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.16,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildReviewDynamicContent(
                            context,
                            title: localization.cashInReviewAmount,
                            content:
                                "${(double.tryParse(controller.amountController.text) ?? 0.0).toStringAsFixed(calculateDecimals)} ${controller.walletCurrency.value}",
                            contentColor: AppColors.success,
                          ),
                          SizedBox(height: 20),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.cashInReviewCharge,
                            content:
                                "${controller.charge.value.toStringAsFixed(calculateDecimals)} ${controller.walletCurrency.value}",
                            contentColor: AppColors.error,
                          ),
                          SizedBox(height: 20),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.cashInReviewAccount,
                            content:
                                controller.recipientUidController.value.text,
                            contentColor: AppColors.black,
                          ),
                          SizedBox(height: 20),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.cashInReviewWallet,
                            content: controller.walletName.value,
                            contentColor: AppColors.black,
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.cashInReviewTotal,
                            content:
                                "${controller.totalAmount.value.toStringAsFixed(calculateDecimals)} ${controller.walletCurrency.value}",
                            contentColor: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    CommonButton(
                      text: localization.cashInReviewCashInButton,
                      onPressed: () {
                        controller.cashIn();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildReviewDynamicContent(
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
