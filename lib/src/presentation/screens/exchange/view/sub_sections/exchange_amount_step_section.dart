import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_wallet_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/exchange/controller/exchange_controller.dart';

class ExchangeAmountStepSection extends StatelessWidget {
  const ExchangeAmountStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            CommonTextInputField(
              isRequired: true,
              backgroundColor: AppColors.transparent,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      PngAssets.inputCircleDollarIcon,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.80),
                      width: 20.w,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 16.h,
                      width: 2.w,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.20),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Get.bottomSheet(
                  CommonDropdownWalletBottomSheet(
                    notFoundText:
                        localization.exchangeAmountDropdownFromWalletsNotFound,
                    dropdownItems: controller.fromExchangeWalletsList,
                    bottomSheetHeight: 420.h,
                    currentlySelectedValue: controller.fromWallet.value!.name,
                    onItemSelected: (value) async {
                      final selectedWallet = controller.fromExchangeWalletsList
                          .firstWhere((w) => w.name == value);
                      controller.fromWallet.value = selectedWallet;
                      controller.fromWalletController.text =
                          controller.fromWallet.value!.name ?? "";
                      controller.calculateExchange();
                    },
                  ),
                );
              },
              labelText: localization.exchangeAmountSelectFromWallet,
              controller: controller.fromWalletController,
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Image.asset(PngAssets.arrowDownCommonIcon, width: 10.w),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20.h),
            CommonTextInputField(
              isRequired: true,
              backgroundColor: AppColors.transparent,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      PngAssets.inputCircleDollarIcon,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.80),
                      width: 20.w,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 16.h,
                      width: 2.w,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.20),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Get.bottomSheet(
                  CommonDropdownWalletBottomSheet(
                    notFoundText:
                        localization.exchangeAmountDropdownToWalletsNotFound,
                    dropdownItems: controller.toExchangeWalletsList,
                    bottomSheetHeight: 420.h,
                    currentlySelectedValue: controller.toWallet.value!.name,
                    onItemSelected: (value) async {
                      final selectedWallet = controller.toExchangeWalletsList
                          .firstWhere((w) => w.name == value);
                      controller.toWallet.value = selectedWallet;
                      controller.toWalletController.text =
                          controller.toWallet.value!.name ?? "";
                      controller.calculateExchange();
                    },
                  ),
                );
              },
              labelText: localization.exchangeAmountSelectToWallet,
              controller: controller.toWalletController,
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Image.asset(PngAssets.arrowDownCommonIcon, width: 10.w),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20.h),
            CommonTextInputField(
              isRequired: true,
              backgroundColor: AppColors.transparent,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      PngAssets.inputDollarIcon,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.80),
                      width: 20.w,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 16.h,
                      width: 2.w,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.20),
                    ),
                  ],
                ),
              ),
              labelText: localization.exchangeAmountEnterAmount,
              controller: controller.amountController,
              keyboardType: TextInputType.number,
            ),
            Obx(
              () => Visibility(
                visible: controller.fromExchangeWalletsList.isNotEmpty,
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localization.exchangeAmountAmountRange(
                          controller.fromWallet.value!.code!,
                          controller.fromWallet.value!.exchangeLimit!.max!,
                          controller.fromWallet.value!.exchangeLimit!.min!,
                        ),
                        style: TextStyle(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              localization.exchangeAmountExchangeRate,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lightTextTertiary,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 5.h),
            Obx(() {
              final fromCode = controller.fromWallet.value?.code ?? "";
              final toCode = controller.toWallet.value?.code ?? "";
              final rate = controller.exchangeRate.value;

              return Text(
                "1 $fromCode = ${rate.toStringAsFixed(DynamicDecimalsHelper().getDynamicDecimals(currencyCode: controller.toWallet.value!.name!, siteCurrencyCode: Get.find<SettingsService>().getSetting("site_currency")!, siteCurrencyDecimals: Get.find<SettingsService>().getSetting("site_currency_decimals")!, isCrypto: controller.toWallet.value!.isCrypto!))} $toCode",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightTextPrimary,
                  letterSpacing: 0,
                  fontSize: 15.sp,
                ),
              );
            }),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CommonButton(
                text: localization.exchangeAmountExchangeButton,
                onPressed: () => controller.nextStepWithValidation(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
