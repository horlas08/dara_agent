import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/create_withdraw_account_controller.dart';

class CreateWithdrawAccount extends StatefulWidget {
  const CreateWithdrawAccount({super.key});

  @override
  State<CreateWithdrawAccount> createState() => _CreateWithdrawAccountState();
}

class _CreateWithdrawAccountState extends State<CreateWithdrawAccount> {
  final CreateWithdrawAccountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              CommonAppBar(title: localization.createWithdrawAccountTitle),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CommonLoading();
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          CommonTextInputField(
                            isRequired: true,
                            backgroundColor: AppColors.transparent,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                              ),
                              child: Image.asset(
                                PngAssets.arrowDownCommonIcon,
                                width: 10,
                              ),
                            ),
                            onTap: () {
                              Get.bottomSheet(
                                CommonDropdownBottomSheet(
                                  notFoundText: localization
                                      .createWithdrawAccountWalletNotFound,
                                  title: localization
                                      .createWithdrawAccountSelectWalletLabel,
                                  dropdownItems: controller.walletsList
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  selectedValue: controller.walletsList
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  isUnselectedValue: true,
                                  selectedItem: controller.wallet,
                                  currentlySelectedValue:
                                      controller.wallet.value,
                                  textController: controller.walletController,
                                  bottomSheetHeight: 400,
                                  onValueSelected: (value) async {
                                    int index = controller.walletsList
                                        .indexWhere((e) => e.name == value);
                                    if (index != -1) {
                                      final selectedWallet =
                                          controller.walletsList[index];
                                      controller.walletId.value = selectedWallet
                                          .id
                                          .toString();
                                      controller.isDefaultWallet.value =
                                          selectedWallet.isDefault ?? false;
                                      controller.withdrawMethodList.clear();
                                      await controller.fetchWithdrawMethods();

                                      controller.withdrawMethod.value = '';
                                      controller.withdrawMethodCurrency.value =
                                          '';
                                      controller.withdrawMethodController
                                          .clear();
                                      controller.methodNameController.clear();
                                      controller.methodName.value = '';
                                      controller.dynamicFieldControllers
                                          .clear();
                                      controller.withdrawMethodId.value = "";
                                      controller.selectedImages.clear();
                                    }
                                  },
                                  onValueUnSelected: () {
                                    controller.wallet.value = "";
                                    controller.walletId.value = "";
                                    controller.isDefaultWallet.value = false;
                                    controller.walletController.clear();
                                    controller.withdrawMethod.value = '';
                                    controller.withdrawMethodCurrency.value =
                                        '';
                                    controller.withdrawMethodController.clear();
                                    controller.withdrawMethodList.clear();
                                    controller.methodNameController.clear();
                                    controller.methodName.value = '';
                                    controller.dynamicFieldControllers.clear();
                                    controller.selectedImages.clear();
                                    controller.withdrawMethodId.value = "";
                                  },
                                ),
                              );
                            },
                            labelText: localization
                                .createWithdrawAccountSelectWalletLabel,
                            controller: controller.walletController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            isRequired: true,
                            backgroundColor: AppColors.transparent,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                              ),
                              child: Image.asset(
                                PngAssets.arrowDownCommonIcon,
                                width: 10,
                              ),
                            ),
                            onTap: () {
                              Get.bottomSheet(
                                CommonDropdownBottomSheet(
                                  notFoundText: localization
                                      .createWithdrawAccountMethodNotFound,
                                  title: localization
                                      .createWithdrawAccountSelectMethodLabel,
                                  dropdownItems: controller.withdrawMethodList
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  selectedValue: controller.withdrawMethodList
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  isUnselectedValue: true,
                                  selectedItem: controller.withdrawMethod,
                                  currentlySelectedValue:
                                      controller.withdrawMethod.value,
                                  textController:
                                      controller.withdrawMethodController,
                                  bottomSheetHeight: 400,
                                  onValueSelected: (value) {
                                    int index = controller.withdrawMethodList
                                        .indexWhere((e) => e.name == value);
                                    if (index != -1) {
                                      final selected =
                                          controller.withdrawMethodList[index];
                                      controller.withdrawMethod.value =
                                          selected.name ?? '';
                                      controller.withdrawMethodCurrency.value =
                                          selected.currency ?? '';
                                      controller.methodNameController.text =
                                          "${selected.name}-${selected.currency}";
                                      controller.methodName.value =
                                          "${selected.name}-${selected.currency}";
                                      controller.withdrawMethodId.value =
                                          selected.id.toString();
                                      controller.dynamicFieldControllers
                                          .clear();
                                      if (selected.fields != null) {
                                        for (var field in selected.fields!) {
                                          controller
                                              .dynamicFieldControllers[field
                                                  .name ??
                                              ''] = {
                                            'controller':
                                                TextEditingController(),
                                            'validation':
                                                field.validation ?? 'nullable',
                                            'type': field.type ?? 'text',
                                          };
                                        }
                                      }
                                    }
                                  },
                                  onValueUnSelected: () {
                                    controller.withdrawMethod.value = '';
                                    controller.withdrawMethodCurrency.value =
                                        '';
                                    controller.withdrawMethodController.clear();
                                    controller.methodNameController.clear();
                                    controller.methodName.value = '';
                                    controller.dynamicFieldControllers.clear();
                                    controller.selectedImages.clear();
                                    controller.withdrawMethodId.value = "";
                                  },
                                ),
                              );
                            },
                            labelText: localization
                                .createWithdrawAccountSelectMethodLabel,
                            controller: controller.withdrawMethodController,
                            readOnly: true,
                          ),

                          Obx(() {
                            return Visibility(
                              visible: controller.methodName.value.isNotEmpty,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  CommonTextInputField(
                                    isRequired: true,
                                    backgroundColor: AppColors.transparent,
                                    controller: controller.methodNameController,
                                    labelText: localization
                                        .createWithdrawAccountMethodNameLabel,
                                  ),
                                ],
                              ),
                            );
                          }),
                          Obx(() {
                            if (controller.dynamicFieldControllers.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                ...controller.dynamicFieldControllers.entries
                                    .map((entry) {
                                      final fieldName = entry.key;
                                      final fieldData = entry.value;

                                      final controller =
                                          fieldData['controller']
                                              as TextEditingController;
                                      final type = fieldData['type'] as String;
                                      final isTextArea = type == 'textarea';
                                      final isFile = type == 'file';
                                      final validation =
                                          fieldData["validation"] == "required";

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
                                                  borderRadius: isTextArea
                                                      ? 8
                                                      : 50,
                                                  labelText: fieldName,
                                                  controller: controller,
                                                  maxLine: isTextArea ? 4 : 1,
                                                  verticalPadding: isTextArea
                                                      ? 8
                                                      : 15.8,
                                                  keyboardType:
                                                      TextInputType.text,
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
                            onPressed: () => controller.createWithdrawAccount(),
                            width: double.infinity,
                            height: 54,
                            text:
                                localization.createWithdrawAccountCreateButton,
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Obx(() {
            return Visibility(
              visible:
                  controller.isWithdrawMethodsLoading.value ||
                  controller.isCreateWithdrawAccountLoading.value,
              child: const CommonLoading(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    required String fieldName,
    bool? validation,
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
                          width: 18,
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
                        Text(
                          validation == true ? " *" : "",
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
