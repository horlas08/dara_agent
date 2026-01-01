import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/support/controller/support_ticket_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/support/model/support_ticket_model.dart';
import 'package:qunzo_agent/src/presentation/screens/support/view/replay_ticket/replay_ticket.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen>
    with WidgetsBindingObserver {
  final SupportTicketController controller = Get.find();
  late ScrollController _scrollController;
  final SettingsService settingsService = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loadData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        controller.hasMorePages.value &&
        !controller.isPageLoading.value) {
      controller.loadMoreSupportTickets();
    }
  }

  Future<void> loadData() async {
    if (!controller.isInitialDataLoaded.value) {
      controller.isLoading.value = true;
      await controller.fetchSupportTickets();
      controller.isLoading.value = false;
      controller.isInitialDataLoaded.value = true;
    }
  }

  Future<void> refreshData() async {
    controller.isLoading.value = true;
    await controller.fetchSupportTickets();
    controller.isLoading.value = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                CommonAppBar(title: localization.supportTicketTitle),
                _buildTransactionsList(),
              ],
            ),

            Visibility(
              visible: controller.isPageLoading.value,
              child: const CommonLoading(),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SizedBox(
          height: 46,
          width: 150,
          child: FloatingActionButton(
            heroTag: null,
            elevation: 0,
            onPressed: () => Get.toNamed(BaseRoute.addNewTicket),
            backgroundColor: AppColors.lightPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(PngAssets.addCommonIcon, width: 16),
                const SizedBox(width: 5),
                Text(
                  localization.supportTicketCreateTicketButton,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15.5,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    final tickets = controller.supportTicketModel.value.data?.tickets ?? [];

    if (controller.isLoading.value) {
      return Expanded(child: CommonLoading());
    }

    if (tickets.isEmpty) {
      return Expanded(child: NoDataFound());
    }

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.lightPrimary,
        onRefresh: () => refreshData(),
        child: controller.isLoading.value
            ? CommonLoading()
            : ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: 50,
                  top: 30,
                ),
                itemBuilder: (context, index) {
                  final Tickets ticket = tickets[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Get.to(
                      () => ReplayTicket(ticketUid: ticket.uuid.toString()),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ticket.title ?? "",
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: AppColors.lightTextPrimary,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      DateFormat(
                                        "dd MMM,yyyy - hh:mm a",
                                      ).format(
                                        DateTime.parse(
                                          ticket.canReply == true
                                              ? ticket.updatedAt!
                                              : ticket.createdAt!,
                                        ),
                                      ),
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.lightTextPrimary
                                            .withValues(alpha: 0.30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 29,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ticket.status == "open"
                                          ? AppColors.success
                                          : AppColors.error,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      ticket.status == "open"
                                          ? "Open"
                                          : "Closed",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Image.asset(
                                    PngAssets.arrowRightCommonIcon,
                                    width: 18,
                                    color: AppColors.lightTextTertiary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Divider(
                            height: 0,
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: tickets.length,
              ),
      ),
    );
  }
}
