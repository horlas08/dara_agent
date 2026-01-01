import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/controller/exchange_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class ExchangeSuccessStepSection extends StatefulWidget {
  const ExchangeSuccessStepSection({super.key});

  @override
  State<ExchangeSuccessStepSection> createState() =>
      _ExchangeSuccessStepSectionState();
}

class _ExchangeSuccessStepSectionState
    extends State<ExchangeSuccessStepSection> {
  final ExchangeController controller = Get.find();
  final settingsService = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.toWallet.value!.code!,
      siteCurrencyCode: settingsService.getSetting("site_currency")!,
      siteCurrencyDecimals: settingsService.getSetting(
        "site_currency_decimals",
      )!,
      isCrypto:
          controller.successExchangeData.value!["transaction"]["is_crypto"],
    );
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Image.asset(PngAssets.successImage, width: 120.w),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      localization.exchangeSuccessTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24.sp,
                        color: AppColors.lightTextPrimary,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      localization.exchangeSuccessSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.30,
                        ),
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessAmount,
                      content:
                          "${double.tryParse(controller.amountController.text)?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessTransactionId,
                      content: controller
                          .successExchangeData
                          .value!["transaction"]["tnx"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessPayAmount,
                      content:
                          "${double.tryParse(controller.successExchangeData.value!["transaction"]["pay_amount"].toString())!.toStringAsFixed(calculateDecimals)} "
                          "${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessConvertedAmount,
                      content:
                          "${double.tryParse(controller.successExchangeData.value!["transaction"]["amount"].toString())?.toStringAsFixed(calculateDecimals)} "
                          "(${controller.successExchangeData.value!["transaction"]["receive_currency"]})",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessCharge,
                      content:
                          "${double.tryParse(controller.successExchangeData.value!["transaction"]["charge"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                      contentColor: AppColors.error,
                    ),
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessDate,
                      content: controller
                          .successExchangeData
                          .value!["transaction"]["created_at"],
                      contentColor: AppColors.lightTextPrimary,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      height: 2.h,
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
                    SizedBox(height: 20.h),
                    _buildSuccessDynamicContent(
                      title: localization.exchangeSuccessFinalAmount,
                      content:
                          "${double.tryParse(controller.successExchangeData.value!["transaction"]["final_amount"].toString())?.toStringAsFixed(calculateDecimals)} ${controller.successExchangeData.value!["transaction"]["pay_currency"]}",
                      contentColor: AppColors.lightTextPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      onPressed: () async {
                        Get.delete<ExchangeController>();
                        Get.offNamed(BaseRoute.navigation);
                        await Get.find<HomeController>().loadData();
                      },
                      textColor: AppColors.lightTextPrimary,
                      text: localization.exchangeSuccessBackHomeButton,
                      backgroundColor: AppColors.lightPrimary.withValues(
                        alpha: 0.16,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: CommonButton(
                      onPressed: () async {
                        controller.clearFields();
                        controller.currentStep.value = 0;
                        controller.isLoading.value = true;
                        await controller.fetchWallets();
                        controller.isLoading.value = false;
                      },
                      text: localization.exchangeSuccessAgainButton,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
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
            fontSize: 14.sp,
            color: AppColors.lightTextTertiary,
            letterSpacing: 0,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
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
