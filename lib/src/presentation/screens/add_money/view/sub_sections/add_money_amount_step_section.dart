import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/controller/add_money_controller.dart';

class AddMoneyAmountStepSection extends StatefulWidget {
  const AddMoneyAmountStepSection({super.key});

  @override
  State<AddMoneyAmountStepSection> createState() =>
      _AddMoneyAmountStepSectionState();
}

class _AddMoneyAmountStepSectionState extends State<AddMoneyAmountStepSection> {
  final AddMoneyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
                  CommonTextInputField(
                    isRequired: true,
                    backgroundColor: AppColors.transparent,
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
                    onTap: () {
                      Get.bottomSheet(
                        CommonDropdownBottomSheet(
                          selectedValue: controller.walletsList
                              .map((item) => item.name.toString())
                              .toList(),
                          dropdownItems: controller.walletsList
                              .map((item) => item.name.toString())
                              .toList(),
                          notFoundText:
                              localization.addMoneyDropdownWalletNotFound,
                          title: localization.addMoneyDropdownSelectWallet,
                          selectedItem: controller.wallet,
                          textController: controller.walletController,
                          currentlySelectedValue: controller.wallet.value,
                          bottomSheetHeight: 300,
                          isUnselectedValue: true,
                          onValueSelected: (value) async {
                            int index = controller.walletsList.indexWhere(
                              (item) => item.name == value,
                            );
                            if (index != -1) {
                              final selectedWallet =
                                  controller.walletsList[index];
                              controller.currencyCode.value =
                                  selectedWallet.code?.toString() ?? "";
                              controller.walletId.value =
                                  selectedWallet.id?.toString() ?? "";
                              controller.isDefaultWallet.value =
                                  selectedWallet.isDefault ?? false;
                              controller.isCrypto.value =
                                  selectedWallet.isCrypto ?? false;
                              controller.gatewayMethodsList.clear();
                              await controller.fetchGatewayMethods();

                              // Clear Gateway
                              controller.gateway.value = "";
                              controller.gatewayId.value = "";
                              controller.gatewayController.clear();
                              controller.charge.value = 0.0;
                              controller.chargeType.value = "";
                              controller.gatewayType.value = "";
                              controller.minimumDeposit.value = 0.0;
                              controller.maximumDeposit.value = 0.0;
                              controller.gatewayCurrency.value = "";
                              controller.currencyDecimals.value = 0;
                              controller.gatewayInstructions.value = "";
                              controller.gatewayCurrencyType.value = "";
                              controller.dynamicFieldControllers.clear();

                              // Clear Selected Images
                              controller.selectedImages.clear();
                            }
                          },
                          onValueUnSelected: () {
                            // Wallet
                            controller.wallet.value = "";
                            controller.currencyCode.value = "";
                            controller.walletId.value = "";
                            controller.isDefaultWallet.value = false;
                            controller.isCrypto.value = false;
                            controller.walletController.clear();

                            // Gateway
                            controller.gateway.value = "";
                            controller.gatewayId.value = "";
                            controller.charge.value = 0.0;
                            controller.chargeType.value = "";
                            controller.minimumDeposit.value = 0.0;
                            controller.maximumDeposit.value = 0.0;
                            controller.gatewayType.value = "";
                            controller.gatewayCurrency.value = "";
                            controller.gatewayInstructions.value = "";
                            controller.gatewayCurrencyType.value = "";
                            controller.currencyDecimals.value = 0;
                            controller.gatewayController.clear();
                            controller.gatewayMethodsList.clear();
                            controller.dynamicFieldControllers.clear();

                            // Clear Selected Images
                            controller.selectedImages.clear();
                          },
                        ),
                      );
                    },
                    labelText: localization.addMoneyDropdownSelectWallet,
                    controller: controller.walletController,
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
                    isRequired: true,
                    backgroundColor: AppColors.transparent,
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
                    onTap: () {
                      Get.bottomSheet(
                        CommonDropdownBottomSheet(
                          notFoundText:
                              localization.addMoneyDropdownGatewayNotFound,
                          title: localization.addMoneyDropdownSelectGateway,
                          onValueSelected: (value) async {
                            int index = controller.gatewayMethodsList
                                .indexWhere(
                                  (item) => item.formattedName == value,
                                );

                            if (index != -1) {
                              final selectedGateway =
                                  controller.gatewayMethodsList[index];
                              controller.charge.value =
                                  double.tryParse(selectedGateway.charge!) ??
                                  0.0;
                              controller.chargeType.value =
                                  selectedGateway.chargeType?.toString() ?? "";
                              controller.minimumDeposit.value =
                                  double.tryParse(
                                    selectedGateway.minimumDeposit!,
                                  ) ??
                                  0.0;
                              controller.maximumDeposit.value =
                                  double.tryParse(
                                    selectedGateway.maximumDeposit!,
                                  ) ??
                                  0.0;
                              controller.gatewayCurrency.value =
                                  selectedGateway.currency ?? "";
                              controller.gatewayType.value =
                                  selectedGateway.type?.toString() ?? "";
                              controller.gatewayInstructions.value =
                                  selectedGateway.instructions?.toString() ??
                                  "";
                              controller.gatewayId.value =
                                  selectedGateway.id?.toString() ?? "";
                              controller.gatewayCurrencyType.value =
                                  selectedGateway.currencyType?.toString() ??
                                  "";
                              controller.currencyDecimals.value =
                                  selectedGateway.currencyDecimals ?? 0;
                              controller.dynamicFieldControllers.clear();
                              if (selectedGateway.fieldOptions != null) {
                                for (var field
                                    in selectedGateway.fieldOptions!) {
                                  controller.dynamicFieldControllers[field
                                          .name ??
                                      ''] = {
                                    'controller': TextEditingController(),
                                    'validation':
                                        field.validation ?? 'nullable',
                                    'type': field.type ?? 'text',
                                  };
                                }
                              }
                            }
                          },
                          selectedValue: controller.gatewayMethodsList
                              .map((item) => item.formattedName.toString())
                              .toList(),
                          dropdownItems: controller.gatewayMethodsList
                              .map((item) => item.formattedName.toString())
                              .toList(),
                          isUnselectedValue: true,
                          onValueUnSelected: () {
                            controller.gateway.value = "";
                            controller.gatewayId.value = "";
                            controller.charge.value = 0.0;
                            controller.chargeType.value = "";
                            controller.minimumDeposit.value = 0.0;
                            controller.maximumDeposit.value = 0.0;
                            controller.gatewayType.value = "";
                            controller.gatewayCurrency.value = "";
                            controller.gatewayInstructions.value = "";
                            controller.gatewayCurrencyType.value = "";
                            controller.currencyDecimals.value = 0;
                            controller.gatewayController.clear();
                            controller.dynamicFieldControllers.clear();

                            // Clear Selected Images
                            controller.selectedImages.clear();
                          },
                          selectedItem: controller.gateway,
                          textController: controller.gatewayController,
                          currentlySelectedValue: controller.gateway.value,
                          bottomSheetHeight: 400,
                        ),
                      );
                    },
                    labelText: localization.addMoneyDropdownSelectGateway,
                    controller: controller.gatewayController,
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
                    isRequired: true,
                    backgroundColor: AppColors.transparent,
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
                    labelText: localization.addMoneyEnterAmount,
                    controller: controller.amountController,
                    keyboardType: TextInputType.number,
                  ),
                  Obx(
                    () => Visibility(
                      visible:
                          controller.minimumDeposit.value != 0.0 &&
                          controller.maximumDeposit.value != 0.0,
                      child: Column(
                        children: [
                          const SizedBox(height: 2),
                          Text(
                            localization.addMoneyAmountRange(
                              controller.gatewayCurrency.value,
                              controller.maximumDeposit.value.toStringAsFixed(
                                controller.currencyDecimals.value,
                              ),
                              controller.minimumDeposit.value.toStringAsFixed(
                                controller.currencyDecimals.value,
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
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.gatewayInstructions.value.isNotEmpty,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.lightPrimary.withValues(
                                alpha: 0.1,
                              ),
                            ),
                            child: HtmlWidget(
                              controller.gatewayInstructions.value,
                              textStyle: TextStyle(
                                letterSpacing: 0,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.dynamicFieldControllers.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ...controller.dynamicFieldControllers.entries.map((
                          entry,
                        ) {
                          final fieldName = entry.key;
                          final fieldData = entry.value;

                          final controller =
                              fieldData['controller'] as TextEditingController;
                          fieldData['validation'] as String;
                          final type = fieldData['type'] as String;
                          final isTextArea = type == 'textarea';
                          final isFile = type == 'file';
                          final validation =
                              fieldData['validation'] == "required";

                          return Column(
                            children: [
                              isFile
                                  ? _buildUploadSection(
                                      title: fieldName,
                                      fieldName: fieldName,
                                      validation: validation,
                                    )
                                  : CommonTextInputField(
                                      isRequired: validation,
                                      borderRadius: isTextArea ? 8 : 50,
                                      backgroundColor: AppColors.transparent,
                                      labelText: fieldName,
                                      controller: controller,
                                      maxLine: isTextArea ? 4 : 1,
                                      verticalPadding: isTextArea ? 8 : 15.8,
                                      keyboardType: TextInputType.text,
                                    ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                  SizedBox(
                    height: controller.dynamicFieldControllers.isEmpty
                        ? 30
                        : 20,
                  ),
                  CommonButton(
                    width: double.infinity,
                    height: 54,
                    text: localization.addMoneyContinueButton,
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

  Widget _buildUploadSection({
    required String title,
    required String fieldName,
    required bool validation,
  }) {
    return Obx(() {
      final selectedImage = controller.selectedImages[fieldName];

      return GestureDetector(
        onTap: () {
          controller.pickImage(fieldName, image_picker.ImageSource.gallery);
        },
        child: SizedBox(
          width: double.infinity,
          height: selectedImage != null ? 120 : null,
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(selectedImage, fit: BoxFit.cover),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      PngAssets.attachFileTwo,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          PngAssets.uploadCommonIcon,
                          width: 20,
                          fit: BoxFit.contain,
                          color: AppColors.lightTextTertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: TextStyle(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.lightTextTertiary,
                          ),
                        ),
                        if (validation == true)
                          Text(
                            " *",
                            style: TextStyle(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.error,
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
}
