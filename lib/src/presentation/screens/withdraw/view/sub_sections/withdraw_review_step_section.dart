import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';

class WithdrawReviewStepSection extends StatefulWidget {
  const WithdrawReviewStepSection({super.key});

  @override
  State<WithdrawReviewStepSection> createState() =>
      _WithdrawReviewStepSectionState();
}

class _WithdrawReviewStepSectionState extends State<WithdrawReviewStepSection> {
  final WithdrawController controller = Get.find();
  final SettingsService settingsService = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final calculateDecimal = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.withdrawAccount.value!.currency!,
      siteCurrencyCode: settingsService.getSetting("site_currency")!,
      siteCurrencyDecimals: settingsService.getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: controller.withdrawAccount.value!.method!.isCrypto!,
    );

    return Obx(
      () => controller.isChargeConverterLoading.value
          ? CommonLoading()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.withdrawReviewTitle,
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
                            title: localization.withdrawReviewAmount,
                            content:
                                "${double.tryParse(controller.amountController.text)!.toStringAsFixed(calculateDecimal)} ${controller.withdrawAccount.value!.currency}",
                            contentColor: AppColors.success,
                          ),
                          SizedBox(height: 20),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.withdrawReviewCharge,
                            content:
                                "${controller.calculatedCharge.value.toStringAsFixed(calculateDecimal)} ${controller.withdrawAccount.value!.currency}",
                            contentColor: AppColors.error,
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
                            title: localization.withdrawReviewTotal,
                            content:
                                "${(controller.totalAmount).toStringAsFixed(calculateDecimal)} ${controller.withdrawAccount.value!.currency}",
                            contentColor: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    CommonButton(
                      text: localization.withdrawReviewWithdrawButton,
                      onPressed: () {
                        controller.submitWithdraw();
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
