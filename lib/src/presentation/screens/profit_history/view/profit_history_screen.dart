import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/profit_history/controller/profit_history_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/profit_history/view/sub_section/profit_history_filter_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/model/transactions_model.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/sub_sections/transaction_details_drop_down.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_agent/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_agent/src/presentation/widgets/transactions_dynamic_color.dart';

class ProfitHistoryScreen extends StatefulWidget {
  const ProfitHistoryScreen({super.key});

  @override
  State<ProfitHistoryScreen> createState() => _ProfitHistoryScreenState();
}

class _ProfitHistoryScreenState extends State<ProfitHistoryScreen>
    with WidgetsBindingObserver {
  final ProfitHistoryController controller = Get.find();
  late ScrollController _scrollController;

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
      controller.loadMoreTransactions();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchTransactions();
    controller.isLoading.value = false;
  }

  Future<void> refreshData() async {
    controller.isLoading.value = true;
    await controller.fetchTransactions();
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
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                CommonAppBar(
                  title: AppLocalizations.of(context)!.profitHistoryTitle,
                  showRightSideWidget: true,
                  rightSideWidget: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(ProfitHistoryFilterBottomSheet());
                    },
                    child: Image.asset(PngAssets.commonFilterIcon, width: 24),
                  ),
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return CommonLoading();
                    }

                    return Column(children: [_buildTransactionsList()]);
                  }),
                ),
              ],
            ),
            Visibility(
              visible:
                  controller.isTransactionsLoading.value ||
                  controller.isPageLoading.value,
              child: const CommonLoading(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    final transactions =
        controller.transactionsModel.value.data?.transactions ?? [];

    if (controller.isLoading.value) {
      return Expanded(child: CommonLoading());
    }

    if (transactions.isEmpty) {
      return Expanded(child: NoDataFound());
    }

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.lightPrimary,
        onRefresh: () => refreshData(),
        child: controller.isLoading.value
            ? CommonLoading()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                ),
                child: ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  itemBuilder: (context, index) {
                    final Transactions transaction = transactions[index];
                    final calculateDecimals = DynamicDecimalsHelper()
                        .getDynamicDecimals(
                          currencyCode: transaction.trxCurrencyCode!,
                          siteCurrencyCode: Get.find<SettingsService>()
                              .getSetting("site_currency")!,
                          siteCurrencyDecimals: Get.find<SettingsService>()
                              .getSetting("site_currency_decimals")!,
                          isCrypto: transaction.isCrypto!,
                        );

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.bottomSheet(
                          TransactionDetailsDropDown(transaction: transaction),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.10,
                            ),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color:
                                          TransactionDynamicColor.getTransactionColor(
                                            transaction.type,
                                          ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        transaction.type == "Cash In"
                                            ? 12
                                            : transaction.type ==
                                                  "Cash Received"
                                            ? 12
                                            : 10,
                                      ),
                                      child: Image.asset(
                                        TransactionDynamicIcon.getTransactionIcon(
                                          transaction.type,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.type ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          transaction.createdAt!
                                              .split(",")
                                              .first,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontSize: 16,
                                            color: AppColors.lightTextPrimary
                                                .withValues(alpha: 0.30),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              "${transaction.trxCurrencySymbol ?? ''}${_formatAmount(transaction.amount, calculateDecimals)}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: transaction.isPlus == true
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: transactions.length,
                ),
              ),
      ),
    );
  }

  String _formatAmount(String? amount, int decimals) {
    if (amount == null || amount.isEmpty) return "0.00";
    final parsed = double.tryParse(amount.replaceAll(",", ""));
    if (parsed == null) return "0.00";
    return parsed.toStringAsFixed(decimals);
  }
}
