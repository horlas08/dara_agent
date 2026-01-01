import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/controller/multiple_image_picker_controller.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/multiple_image_picker_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/support/controller/add_new_ticket_controller.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  final AddNewTicketController controller = Get.find();

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
              CommonAppBar(title: localization.addNewTicketTitle),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        CommonTextInputField(
                          backgroundColor: AppColors.transparent,
                          controller: controller.titleController,
                          hintText: localization.addNewTicketTitleHint,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 20),
                        CommonTextInputField(
                          borderRadius: 8,
                          verticalPadding: 8,
                          backgroundColor: AppColors.transparent,
                          controller: controller.descriptionController,
                          keyboardType: TextInputType.text,
                          hintText: localization.addNewTicketDescriptionHint,
                          maxLine: 4,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              localization.addNewTicketAttachments,
                              style: TextStyle(
                                letterSpacing: 0,
                                color: AppColors.lightTextPrimary,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.addAttachment(),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: AppColors.lightPrimary,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(PngAssets.addCommonIcon),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => Column(
                            children: controller.attachments
                                .map(
                                  (id) => Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: _buildAttachmentItem(
                                      context,
                                      id,
                                      controller,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 30),
                        CommonButton(
                          onPressed: () async {
                            if (!controller.validateForm()) {
                              return;
                            }
                            await controller.addNewTicket();
                          },
                          width: double.infinity,
                          height: 54,
                          text: localization.addNewTicketAddButton,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isAddTicketLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(
    BuildContext context,
    int id,
    AddNewTicketController controller,
  ) {
    final localization = AppLocalizations.of(context)!;
    final MultipleImagePickerController multipleImagePickerController = Get.put(
      MultipleImagePickerController(),
    );

    return GestureDetector(
      onTap: () {
        showImageSourceSheet(id);
      },
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(PngAssets.attachFileTwo),
            if (multipleImagePickerController.images.containsKey(id))
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  multipleImagePickerController.images[id]!,
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            if (!multipleImagePickerController.images.containsKey(id))
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
                    localization.addNewTicketAttachFile,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.lightTextTertiary,
                    ),
                  ),
                ],
              ),
            if (controller.attachments.length > 1 ||
                multipleImagePickerController.images.containsKey(id))
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => controller.removeAttachment(id),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      PngAssets.closeCommonIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showImageSourceSheet(int attachmentId) {
    Get.bottomSheet(
      MultipleImagePickerDropdownBottomSheet(attachmentId: attachmentId),
    );
  }
}
