import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/controller/exchange_controller.dart';

class ExchangeReviewStepSection extends StatefulWidget {
  const ExchangeReviewStepSection({super.key});

  @override
  State<ExchangeReviewStepSection> createState() =>
      _ExchangeReviewStepSectionState();
}

class _ExchangeReviewStepSectionState extends State<ExchangeReviewStepSection> {
  final ExchangeController controller = Get.find();
  final SettingsService settingsService = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final fromCalculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.fromWallet.value!.code!,
      siteCurrencyCode: Get.find<SettingsService>().getSetting(
        "site_currency",
      )!,
      siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: controller.fromWallet.value!.isCrypto!,
    );

    final toCalculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: controller.toWallet.value!.code!,
      siteCurrencyCode: Get.find<SettingsService>().getSetting(
        "site_currency",
      )!,
      siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: controller.toWallet.value!.isCrypto!,
    );

    return Obx(
      () => controller.isExchangeConfigLoading.value
          ? Expanded(child: CommonLoading())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      localization.exchangeReviewTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                        fontSize: 18.sp,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
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
                            title: localization.exchangeReviewAmount,
                            content:
                                "${double.tryParse(controller.amountController.text)?.toStringAsFixed(fromCalculateDecimals)} ${controller.fromWallet.value!.code!}",
                            contentColor: AppColors.success,
                          ),
                          SizedBox(height: 20.h),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.exchangeReviewFromWallet,
                            content: controller.fromWallet.value!.name!,
                            contentColor: AppColors.lightTextPrimary,
                          ),
                          SizedBox(height: 20.h),
                          _buildReviewDynamicContent(
                            context,
                            title: localization.exchangeReviewCharge,
                            content:
                                "${double.tryParse(controller.charge.value.toString())!.toStringAsFixed(fromCalculateDecimals)} ${controller.fromWallet.value!.code!}",
                            contentColor: AppColors.error,
                          ),
                          SizedBox(height: 20.h),
                          Obx(
                            () => _buildReviewDynamicContent(
                              context,
                              title: localization.exchangeReviewTotalAmount,
                              content:
                                  "${double.tryParse(controller.totalAmount.value.toString())!.toStringAsFixed(fromCalculateDecimals)} ${controller.fromWallet.value!.code!}",
                              contentColor: AppColors.success,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Obx(
                            () => _buildReviewDynamicContent(
                              context,
                              title: localization.exchangeReviewToWallet,
                              content: controller.toWallet.value!.name!,
                              contentColor: AppColors.lightTextPrimary,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Obx(
                            () => _buildReviewDynamicContent(
                              context,
                              title: localization.exchangeReviewExchangeRate,
                              content:
                                  "1 ${controller.fromWallet.value!.code} = ${controller.exchangeReviewRate.value.toStringAsFixed(toCalculateDecimals)} ${controller.toWallet.value!.code}",
                              contentColor: AppColors.lightTextPrimary,
                            ),
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
                          Obx(
                            () => _buildReviewDynamicContent(
                              context,
                              title: localization.exchangeReviewExchangeAmount,
                              content:
                                  "${controller.exchangeAmount.value.toStringAsFixed(toCalculateDecimals)} ${controller.toWallet.value!.code}",
                              contentColor: AppColors.lightTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CommonButton(
                      text: localization.exchangeReviewExchangeNowButton,
                      onPressed: () {
                        controller.exchangeWallet();
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
            fontSize: 15.sp,
            color: AppColors.lightTextTertiary,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
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
