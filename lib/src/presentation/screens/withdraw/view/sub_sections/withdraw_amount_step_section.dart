import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet_three.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/model/withdraw_account_model.dart';

class WithdrawAmountStepSection extends StatelessWidget {
  const WithdrawAmountStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawController controller = Get.find();
    final localization = AppLocalizations.of(context)!;
    return Obx(
      () => controller.isLoading.value
          ? CommonLoading()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 4,
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
                  const SizedBox(height: 30),
                  CommonTextInputField(
                    backgroundColor: AppColors.transparent,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            PngAssets.withdrawAccountInputIcon,
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
                    onTap: () {
                      Get.bottomSheet(
                        CommonDropdownBottomSheetThree<Accounts>(
                          items: controller.accountList,
                          selectedItem: controller.withdrawAccount.value,
                          bottomSheetHeight: 400,
                          isShowTitle: true,
                          title: localization.withdrawAccountTitle,
                          notFoundText: localization.withdrawAccountNotFound,
                          getDisplayText: (account) => account.methodName ?? "",
                          areItemsEqual: (account1, account2) =>
                              account1.id == account2.id,
                          getItemIcon: (account) => account.method?.icon,
                          getItemSubtitle: (account) =>
                              localization.withdrawAccountCurrencySubtitle(
                                account.currency!,
                              ),
                          getItemDescription: (account) {
                            if (account.method != null) {
                              return localization
                                  .withdrawAccountMinMaxDescription(
                                    account.method!.maxWithdraw!,
                                    account.method!.minWithdraw!,
                                  );
                            }
                            return null;
                          },

                          onItemSelected: (selectedAccount) {
                            controller.withdrawAccount.value = selectedAccount;
                            controller.withdrawAccountController.text =
                                selectedAccount.methodName ?? "";
                          },

                          onItemUnSelected: () {
                            controller.withdrawAccount.value = Accounts();
                            controller.withdrawAccountController.clear();
                          },
                        ),
                      );
                    },
                    hintText: localization.withdrawAmountSelectAccountHint,
                    controller: controller.withdrawAccountController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Image.asset(
                        PngAssets.arrowDownCommonIcon,
                        width: 10,
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  CommonTextInputField(
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
                    backgroundColor: AppColors.transparent,
                    hintText: localization.withdrawAmountAmountHint,
                    controller: controller.amountController,
                    keyboardType: TextInputType.number,
                  ),
                  Obx(() {
                    final withdrawAccount = controller.withdrawAccount.value;
                    final hasAccount =
                        withdrawAccount != null &&
                        controller.withdrawAccountController.text.isNotEmpty;

                    if (!hasAccount) {
                      return const SizedBox.shrink();
                    }

                    final calculateDecimals = DynamicDecimalsHelper()
                        .getDynamicDecimals(
                          currencyCode: withdrawAccount.currency ?? "",
                          siteCurrencyCode:
                              Get.find<SettingsService>().getSetting(
                                "site_currency",
                              ) ??
                              "",
                          siteCurrencyDecimals:
                              Get.find<SettingsService>().getSetting(
                                "site_currency_decimals",
                              ) ??
                              "2",
                          isCrypto: withdrawAccount.method?.isCrypto ?? false,
                        );

                    final min =
                        double.tryParse(
                          withdrawAccount.method?.minWithdraw ?? "0",
                        )?.toStringAsFixed(calculateDecimals) ??
                        "0.00";

                    final max =
                        double.tryParse(
                          withdrawAccount.method?.maxWithdraw ?? "0",
                        )?.toStringAsFixed(calculateDecimals) ??
                        "0.00";

                    return Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        localization.withdrawAmountRangeMessage(
                          withdrawAccount.currency!,
                          max,
                          min,
                        ),
                        style: TextStyle(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                  CommonButton(
                    width: double.infinity,
                    height: 54,
                    text: localization.withdrawAmountContinueButton,
                    onPressed: () {
                      controller.nextStepWithValidation();
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
    );
  }
}
