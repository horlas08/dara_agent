import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/controller/multiple_image_picker_controller.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/multiple_image_picker_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/support/controller/reply_ticket_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/support/model/ticket_message_model.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';

class ReplayTicket extends StatefulWidget {
  final String ticketUid;

  const ReplayTicket({super.key, required this.ticketUid});

  @override
  State<ReplayTicket> createState() => _ReplayTicketState();
}

class _ReplayTicketState extends State<ReplayTicket> {
  final ReplyTicketController controller = Get.put(ReplyTicketController());
  final localization = AppLocalizations.of(Get.context!)!;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    controller.clearForm();
    controller.isLoading.value = true;
    await controller.fetchTicketMessage(ticketUid: widget.ticketUid);
    controller.isLoading.value = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    if (controller.messageController.text.isNotEmpty) {
      await controller.submitReplayTicket(ticketUid: widget.ticketUid);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } else {
      ToastHelper().showErrorToast(localization.replyTicketMessageEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Stack(
        children: [
          Obx(() {
            final isLoading = controller.isLoading.value;

            if (isLoading) {
              return const CommonLoading();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                CommonAppBar(
                  title:
                      "#${controller.ticketMessageModel.value.data!.ticket!.uuid!}",
                  showRightSideWidget: true,

                  rightSideWidget: GestureDetector(
                    onTap: () => controller.submitCloseTicket(
                      ticketUid: widget.ticketUid,
                    ),
                    child: Text(
                      localization.replyTicketCloseButton,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.error,
                        decorationThickness: 1.5,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.lightPrimary.withValues(alpha: 0.10),
                        width: 2,
                      ),
                    ),
                    child: RefreshIndicator(
                      color: AppColors.lightPrimary,
                      onRefresh: () => loadData(),
                      child: Obx(() {
                        final model = controller.ticketMessageModel.value;
                        final messages = model.data?.messages ?? [];
                        final ticket = model.data?.ticket;

                        return SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              if (ticket != null)
                                _buildMessageBubble(
                                  context,
                                  isMe: false,
                                  name: ticket.user?.name ?? "",
                                  email: ticket.user?.email ?? "",
                                  message: ticket.message ?? "",
                                  personAvatar: ticket.user?.avatar ?? "",
                                  attachments: ticket.attachments ?? [],
                                  firstMessageDate: ticket.createdAt ?? "",
                                ),
                              ...messages.map((item) {
                                return _buildMessageBubble(
                                  context,
                                  isMe: item.isAdmin ?? false,
                                  name: item.user?.name ?? "",
                                  email: item.user?.email ?? "",
                                  message: item.message ?? "",
                                  personAvatar: item.user?.avatar ?? "",
                                  attachments: item.attachments ?? [],
                                  messageDate: item.createdAtFormatted ?? "",
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttachmentPreview(context),
                      Row(
                        children: [
                          Expanded(child: _buildReplyInput(context)),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              final newId =
                                  DateTime.now().millisecondsSinceEpoch;
                              Get.bottomSheet(
                                MultipleImagePickerDropdownBottomSheet(
                                  attachmentId: newId,
                                ),
                              );
                            },
                            child: Image.asset(
                              PngAssets.replyTicketAttachment,
                              width: 22,
                              color: AppColors.lightTextPrimary.withValues(
                                alpha: 0.40,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          _buildActionButtons(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          Obx(
            () => Visibility(
              visible:
                  controller.isCloseTicketLoading.value ||
                  controller.isReplayTicketLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context, {
    required bool isMe,
    required String name,
    required String email,
    required String message,
    required String personAvatar,
    required List<Attachments> attachments,
    String? firstMessageDate,
    String? messageDate,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMe) ...[
            Flexible(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color(0xFFF8F8F8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            personAvatar,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                PngAssets.profileImage,
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  letterSpacing: 0,

                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.lightTextPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                email,
                                style: TextStyle(
                                  letterSpacing: 0,

                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightTextTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildMessageContent(
                      message: message,
                      attachments: attachments,
                      isMe: isMe,
                      messageDate: messageDate,
                      firstMessageDate: firstMessageDate,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(flex: 1, child: SizedBox()),
          ] else ...[
            Flexible(flex: 1, child: SizedBox()),
            Flexible(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: _buildMessageContent(
                  message: message,
                  attachments: attachments,
                  isMe: isMe,
                  messageDate: messageDate,
                  firstMessageDate: firstMessageDate,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageContent({
    required String message,
    required List<Attachments> attachments,
    required bool isMe,
    String? messageDate,
    String? firstMessageDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
            letterSpacing: 0,

            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isMe
                ? AppColors.lightTextPrimary.withValues(alpha: 0.80)
                : AppColors.white,
          ),
        ),
        if (attachments.isNotEmpty) ...[
          SizedBox(height: 10),
          Text(
            localization.replyTicketAttachments,
            style: TextStyle(
              letterSpacing: 0,

              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: isMe
                  ? AppColors.lightTextPrimary.withValues(alpha: 0.80)
                  : AppColors.white,
            ),
          ),
          SizedBox(height: 4),
          ...attachments.map((attachment) {
            final fileName = _extractFileName(attachment.url ?? '');
            final attachmentUrl = attachment.url ?? '';
            return GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutQuart,
                    height: 400,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.06),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 12),
                        Container(
                          width: 45,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localization.replyTicketAttachmentPreview,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: AppColors.lightTextPrimary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Image.asset(
                                  PngAssets.closeCommonIcon,
                                  width: 28,
                                  color: AppColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
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
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              attachmentUrl,
                              fit: BoxFit.contain,
                              loadingBuilder: (ctx, child, progress) {
                                if (progress == null) return child;
                                return CommonLoading();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return NoDataFound();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Image.asset(
                      PngAssets.albumCommonIcon,
                      width: 15,
                      height: 15,
                      color: isMe
                          ? AppColors.lightTextPrimary.withValues(alpha: 0.80)
                          : AppColors.white,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        fileName,
                        style: TextStyle(
                          letterSpacing: 0,

                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: isMe
                              ? AppColors.lightTextPrimary.withValues(
                                  alpha: 0.80,
                                )
                              : AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
        SizedBox(height: 10),
        Align(
          alignment: !isMe
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          child: Text(
            messageDate ??
                intl.DateFormat(
                  "dd MMM, yyyy hh:mm a",
                ).format(DateTime.parse(firstMessageDate!)),
            style: TextStyle(
              letterSpacing: 0,

              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: isMe
                  ? AppColors.lightTextPrimary.withValues(alpha: 0.60)
                  : AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  String _extractFileName(String url) {
    if (url.isEmpty) return localization.replyTicketUnknownFile;

    try {
      String cleanUrl = url.replaceAll(RegExp(r'["\[\]]'), '');

      List<String> parts = cleanUrl.split('/');
      if (parts.isNotEmpty) {
        return parts.last;
      }
      return localization.replyTicketUnknownFile;
    } catch (e) {
      return localization.replyTicketUnknownFile;
    }
  }

  Widget _buildReplyInput(BuildContext context) {
    return CommonTextInputField(
      verticalPadding: 12,
      controller: controller.messageController,
      hintText: localization.replyTicketTypeMessageHint,
      keyboardType: TextInputType.text,
      backgroundColor: Color(0xFFF3F3F3),
      showBorder: false,
      hintStyle: TextStyle(
        color: AppColors.lightTextPrimary.withValues(alpha: 0.40),
        fontWeight: FontWeight.w700,
        fontSize: 16,
        letterSpacing: 0,
      ),
    );
  }

  Widget _buildAttachmentPreview(BuildContext context) {
    final MultipleImagePickerController multipleImagePickerController = Get.put(
      MultipleImagePickerController(),
    );

    return Obx(
      () => SizedBox(
        height: multipleImagePickerController.images.isEmpty ? 0 : 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...multipleImagePickerController.images.entries.map((entry) {
                  final int id = entry.key;
                  final File imageFile = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.black.withValues(alpha: 0.10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              imageFile,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: () =>
                                multipleImagePickerController.removeImage(id),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              width: 20,
                              height: 20,
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
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return CommonButton(
      text: localization.replyTicketSendButton,
      onPressed: _sendMessage,
      width: 90,
      height: 46,
    );
  }
}
