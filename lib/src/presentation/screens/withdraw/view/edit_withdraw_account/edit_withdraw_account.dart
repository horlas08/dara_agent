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
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/edit_withdraw_account_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/model/withdraw_account_model.dart';

class EditWithdrawAccount extends StatefulWidget {
  final Accounts account;

  const EditWithdrawAccount({super.key, required this.account});

  @override
  State<EditWithdrawAccount> createState() => _EditWithdrawAccountState();
}

class _EditWithdrawAccountState extends State<EditWithdrawAccount> {
  final EditWithdrawAccountController controller = Get.put(
    EditWithdrawAccountController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeFields(widget.account);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              CommonAppBar(title: localization.editWithdrawAccountTitle),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            CommonTextInputField(
                              controller: controller.methodNameController,
                              hintText: localization
                                  .editWithdrawAccountMethodNameHint,
                              backgroundColor: AppColors.transparent,
                            ),
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  ...controller.dynamicFieldControllers.entries
                                      .map((entry) {
                                        final fieldName = entry.key;
                                        final fieldData = entry.value;

                                        final fieldController =
                                            fieldData['controller']
                                                as TextEditingController;
                                        final type =
                                            fieldData['type'] as String;
                                        final existingValue =
                                            fieldData['value'] as String;
                                        final isTextArea = type == 'textarea';
                                        final isFile = type == 'file';

                                        return Column(
                                          children: [
                                            isFile
                                                ? _buildUploadSection(
                                                    title: fieldName,
                                                    fieldName: fieldName,
                                                    existingValue:
                                                        existingValue,
                                                  )
                                                : CommonTextInputField(
                                                    borderRadius: isTextArea
                                                        ? 8
                                                        : 50,
                                                    hintText: fieldName,
                                                    controller: fieldController,
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
                              ),
                            ),
                            SizedBox(
                              height: controller.dynamicFieldControllers.isEmpty
                                  ? 30
                                  : 20,
                            ),
                            CommonButton(
                              onPressed: () => controller.updateWithdrawAccount(
                                accountId: widget.account.id.toString(),
                              ),
                              width: double.infinity,
                              height: 54,
                              text:
                                  localization.editWithdrawAccountUpdateButton,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    required String fieldName,
    String? existingValue,
  }) {
    return Obx(() {
      final selectedImage = controller.selectedImages[fieldName];
      final hasExistingValue =
          existingValue != null &&
          existingValue.isNotEmpty &&
          existingValue.toLowerCase() != 'null';

      return GestureDetector(
        onTap: () {
          controller.pickImage(fieldName, image_picker.ImageSource.gallery);
        },
        child: Container(
          width: double.infinity,
          height: selectedImage != null || hasExistingValue ? 120 : 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    selectedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : hasExistingValue
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    existingValue,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: AppColors.lightTextTertiary,
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CommonLoading();
                    },
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      PngAssets.attachFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          PngAssets.uploadCommonIcon,
                          width: 18,
                          fit: BoxFit.contain,
                          color: AppColors.lightTextTertiary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: AppColors.lightTextTertiary,
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
