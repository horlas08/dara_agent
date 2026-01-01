import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/controller/transactions_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/model/transactions_model.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/sub_sections/transaction_details_drop_down.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/sub_sections/transaction_filter_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/sub_sections/transaction_type_list.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_agent/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_agent/src/presentation/widgets/transactions_dynamic_color.dart';

class TransactionsScreen extends StatefulWidget {
  final bool? isTransactionMainScreen;

  const TransactionsScreen({super.key, this.isTransactionMainScreen = false});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with WidgetsBindingObserver {
  final TransactionsController controller = Get.put(TransactionsController());
  late ScrollController _scrollController;
  final bool isTransactionMainScreen =
      (Get.arguments != null && Get.arguments is Map<String, dynamic>)
      ? Get.arguments["is_transaction_main_screen"] ?? false
      : false;

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
    if (controller.hasActiveFilters()) {
      controller.isLoading.value = true;
      await controller.fetchDynamicTransactions();
      controller.isLoading.value = false;
    } else {
      controller.isLoading.value = true;
      await controller.fetchTransactions();
      controller.isLoading.value = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _handleBackNavigation() {
    if (widget.isTransactionMainScreen == true ||
        isTransactionMainScreen == true) {
      final HomeController homeController = Get.find();
      if (homeController.selectedIndex.value == 0) {
        Get.back();
      } else if (homeController.selectedIndex.value == 2) {
        homeController.selectedIndex.value = 0;
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: Scaffold(
        appBar: CommonDefaultAppBar(),
        body: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  isTransactionMainScreen == true ||
                          widget.isTransactionMainScreen == true
                      ? CommonAppBar(
                          title: localization.transactionsTitle,
                          selectedIndex: 0,
                          showRightSideWidget: true,
                          rightSideWidget: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(TransactionFilterBottomSheet());
                            },
                            child: Image.asset(
                              PngAssets.commonFilterIcon,
                              width: 24,
                            ),
                          ),
                        )
                      : CommonAppBar(
                          title: localization.transactionsTitle,
                          showRightSideWidget: true,
                          rightSideWidget: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(TransactionFilterBottomSheet());
                            },
                            child: Image.asset(
                              PngAssets.commonFilterIcon,
                              width: 24,
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return CommonLoading();
                      }

                      return Column(
                        children: [
                          SizedBox(height: 33, child: TransactionTypeList()),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 3,
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
                          _buildTransactionsList(),
                        ],
                      );
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
                margin: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.white,
                ),
                child: ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
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
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Get.bottomSheet(
                          TransactionDetailsDropDown(transaction: transaction),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.lightTextPrimary.withValues(
                              alpha: 0.10,
                            ),
                            width: 1.5.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 42.w,
                                    height: 42.w,
                                    decoration: BoxDecoration(
                                      color:
                                          TransactionDynamicColor.getTransactionColor(
                                            transaction.type,
                                          ),
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        transaction.type == "Cash In"
                                            ? 12.r
                                            : transaction.type ==
                                                  "Cash Received"
                                            ? 10.r
                                            : transaction.type == "Exchange"
                                            ? 12.r
                                            : transaction.type == "Deposit"
                                            ? 12.r
                                            : transaction.type == "Credit"
                                            ? 12.r
                                            : transaction.type ==
                                                  "Cash In Commission"
                                            ? 10.r
                                            : 8.r,
                                      ),
                                      child: Image.asset(
                                        TransactionDynamicIcon.getTransactionIcon(
                                          transaction.type,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.type ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16.sp,
                                            color: AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          transaction.createdAt!
                                              .split(",")
                                              .first,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            fontSize: 14.sp,
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
                                fontSize: 16.sp,
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
                    return SizedBox(height: 12.h);
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
