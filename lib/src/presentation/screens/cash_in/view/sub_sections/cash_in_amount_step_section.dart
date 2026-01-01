import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/controller/cash_in_controller.dart';
import 'package:qunzo_agent/src/presentation/widgets/qr_scanner_screen.dart';

class CashInAmountStepSection extends StatefulWidget {
  const CashInAmountStepSection({super.key});

  @override
  State<CashInAmountStepSection> createState() =>
      _CashInAmountStepSectionState();
}

class _CashInAmountStepSectionState extends State<CashInAmountStepSection> {
  final CashInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Obx(
      () => controller.isLoading.value
          ? CommonLoading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    CommonTextInputField(
                      backgroundColor: AppColors.transparent,
                      onTap: () {
                        Get.bottomSheet(
                          CommonDropdownBottomSheet(
                            notFoundText:
                                localization.cashInAmountDropdownWalletNotFound,
                            title: localization.cashInAmountSelectWallet,
                            onValueSelected: (value) async {
                              int index = controller.walletsList.indexWhere(
                                (item) => item.name == value,
                              );
                              if (index != -1) {
                                final selectedWallet =
                                    controller.walletsList[index];
                                controller.walletCurrency.value =
                                    selectedWallet.code ?? "";
                                controller.isCrypto.value =
                                    selectedWallet.isCrypto ?? false;
                                controller.cashInMinLimit.value =
                                    double.tryParse(
                                      selectedWallet.cashinLimit!.min!,
                                    ) ??
                                    0.0;
                                controller.cashInMaxLimit.value =
                                    double.tryParse(
                                      selectedWallet.cashinLimit!.max!,
                                    ) ??
                                    0.0;
                                controller.walletName.value =
                                    selectedWallet.name ?? "";
                                controller.walletId.value = selectedWallet.id
                                    .toString();
                                controller.isDefaultWallet.value =
                                    selectedWallet.isDefault ?? false;
                              }
                            },
                            selectedValue: controller.walletsList
                                .map((item) => item.name.toString())
                                .toList(),
                            dropdownItems: controller.walletsList
                                .map((item) => item.name.toString())
                                .toList(),
                            isUnselectedValue: true,
                            onValueUnSelected: () {
                              controller.wallet.value = "";
                              controller.walletCurrency.value = "";
                              controller.cashInMinLimit.value = 0.0;
                              controller.cashInMaxLimit.value = 0.0;
                              controller.walletName.value = "";
                              controller.walletId.value = "";
                              controller.isCrypto.value = false;
                              controller.isDefaultWallet.value = false;
                              controller.walletController.clear();
                            },
                            selectedItem: controller.wallet,
                            textController: controller.walletController,
                            currentlySelectedValue: controller.wallet.value,
                            bottomSheetHeight: 350,
                          ),
                        );
                      },
                      hintText: localization.cashInAmountSelectWallet,
                      controller: controller.walletController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              PngAssets.inputCircleDollarIcon,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.80,
                              ),
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 16,
                              width: 2,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Image.asset(
                          PngAssets.arrowDownCommonIcon,
                          width: 10,
                        ),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 20),
                    CommonTextInputField(
                      backgroundColor: AppColors.transparent,
                      hintText: localization.cashInAmountRecipientUid,
                      controller: controller.recipientUidController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              PngAssets.accountNumberIcon,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.80,
                              ),
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 16,
                              width: 2,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          final scannedCode = await Get.to(
                            () => const QrScannerScreen(),
                          );

                          if (scannedCode != null) {
                            if (scannedCode.startsWith("UID:")) {
                              final midValue = scannedCode
                                  .replaceAll("UID:", "")
                                  .trim();

                              final isNumeric = RegExp(
                                r'^\d+$',
                              ).hasMatch(midValue);

                              if (isNumeric) {
                                controller.recipientUidController.text =
                                    midValue;
                              } else {
                                ToastHelper().showErrorToast(
                                  localization.cashInAmountQrInvalidDigitsOnly,
                                );
                              }
                            } else {
                              ToastHelper().showErrorToast(
                                localization
                                    .cashInAmountQrInvalidPrefixNotFound,
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Image.asset(
                            PngAssets.profileSettingsCameraIcon,
                            width: 10,
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CommonTextInputField(
                      backgroundColor: AppColors.transparent,
                      hintText: localization.cashInAmountEnterAmount,
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              PngAssets.inputDollarIcon,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.80,
                              ),
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 16,
                              width: 2,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      final calculateDecimals = DynamicDecimalsHelper()
                          .getDynamicDecimals(
                            currencyCode: controller.walletCurrency.value,
                            siteCurrencyCode: Get.find<SettingsService>()
                                .getSetting("site_currency")!,
                            siteCurrencyDecimals: Get.find<SettingsService>()
                                .getSetting("site_currency_decimals")!,
                            isCrypto: controller.isCrypto.value,
                          );

                      return Visibility(
                        visible:
                            controller.cashInMinLimit.value != 0.0 &&
                            controller.cashInMaxLimit.value != 0.0,
                        child: Column(
                          children: [
                            const SizedBox(height: 2),
                            Text(
                              localization.cashInAmountAmountRange(
                                controller.walletCurrency.value,
                                controller.cashInMinLimit.value.toStringAsFixed(
                                  calculateDecimals,
                                ),
                                controller.cashInMaxLimit.value.toStringAsFixed(
                                  calculateDecimals,
                                ),
                              ),
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    CommonButton(
                      width: double.infinity,
                      height: 54,
                      text: localization.cashInAmountContinueButton,
                      onPressed: () {
                        controller.nextStepWithValidation();
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}
