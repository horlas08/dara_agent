import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_wallet_bottom_sheet.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/model/transactions_model.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/sub_sections/transaction_details_drop_down.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/wallet_details_controller.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_agent/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_agent/src/presentation/widgets/transactions_dynamic_color.dart';

class WalletDetails extends StatefulWidget {
  const WalletDetails({super.key});

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  final WalletDetailsController controller = Get.find();
  final walletId = Get.arguments['wallet_id'];
  final walletImage = Get.arguments['wallet_image'];
  late ScrollController _scrollController;

  late String detailsImage;
  final Random _random = Random();

  final List<String> _detailImages = [
    PngAssets.walletDetailsCardOne,
    PngAssets.walletDetailsCardTwo,
    PngAssets.walletsDetailsCardThree,
    PngAssets.walletsDetailsCardFour,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    controller.resetPagination();
    loadData();
    detailsImage = getDetailsImage(walletImage);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreTransactions();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWallets(id: walletId);
    await controller.fetchTransactions(isRefresh: true);
    controller.isLoading.value = false;
  }

  Future<void> _onRefresh() async {
    await controller.fetchTransactions(isRefresh: true);
  }

  String getRandomDetailsImage() {
    return _detailImages[_random.nextInt(_detailImages.length)];
  }

  String getDetailsImage(String image) {
    if (image == PngAssets.walletOne) {
      return PngAssets.walletDetailsCardOne;
    } else if (image == PngAssets.walletTwo) {
      return PngAssets.walletDetailsCardTwo;
    } else if (image == PngAssets.walletThree) {
      return PngAssets.walletsDetailsCardThree;
    } else if (image == PngAssets.walletFour) {
      return PngAssets.walletsDetailsCardFour;
    } else {
      return PngAssets.walletDetailsCardOne;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Obx(
        () => controller.isLoading.value
            ? CommonLoading()
            : RefreshIndicator(
                color: AppColors.lightPrimary,
                onRefresh: _onRefresh,
                child: Column(
                  children: [
                    _buildWalletHeaderSection(),
                    const SizedBox(height: 16),
                    _buildButtonsSection(),
                    const SizedBox(height: 16),
                    _buildTransactionsList(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildButtonsSection() {
    final localization = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              title: localization.walletDetailsTopUp,
              icon: PngAssets.topUpCommonIcon,
              iconBgColor: Color(0xFFF2DCAC),
              onTap: () => Get.toNamed(
                BaseRoute.addMoney,
                arguments: {"wallet_id": controller.walletId.toString()},
              ),
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: _buildActionButton(
              title: localization.walletDetailsWithdraw,
              icon: PngAssets.withdrawCommonIcon,
              iconBgColor: Color(0xFFC4C5FF),
              onTap: () => Get.toNamed(BaseRoute.withdraw),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletHeaderSection() {
    final localization = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          CommonDropdownWalletBottomSheet(
            notFoundText: localization.walletDetailsWalletsNotFound,
            dropdownItems: controller.walletsList,
            bottomSheetHeight: 400,
            currentlySelectedValue: controller.wallet.value!.name,
            onItemSelected: (value) async {
              final selectedWallet = controller.walletsList.firstWhere(
                (w) => w.name == value,
              );

              controller.wallet.value = selectedWallet;
              controller.walletName.value = selectedWallet.name ?? "";
              controller.walletIcon.value =
                  (selectedWallet.isDefault == true
                      ? selectedWallet.symbol
                      : selectedWallet.icon) ??
                  "";
              controller.walletId.value = selectedWallet.id.toString();

              setState(() {
                detailsImage = getRandomDetailsImage();
              });
              await controller.fetchTransactions(isRefresh: true);
            },
          ),
        );
      },
      child: Stack(
        children: [
          Image.asset(detailsImage, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(PngAssets.arrowLeftCommonIcon, width: 22),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      controller.wallet.value!.name ?? "",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightTextPrimary.withValues(
                          alpha: 0.80,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Image.asset(PngAssets.arrowDownCommonIcon, width: 20),
                  ],
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        controller.wallet.value!.formattedBalance!,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: AppColors.lightTextPrimary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -1),
                        child: Text(
                          "  ${controller.wallet.value!.code}",
                          style: TextStyle(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 38,
            right: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.wallet.value!.name ?? "",
                      style: TextStyle(
                        letterSpacing: 0,
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      controller.wallet.value!.symbol ?? "...",
                      style: TextStyle(
                        letterSpacing: 0,
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  controller.wallet.value!.code ?? "",
                  style: TextStyle(
                    letterSpacing: 0,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required String icon,
    required Color iconBgColor,
    required GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(icon),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    final transactions = controller.allTransactions;
    final localization = AppLocalizations.of(context)!;
    if (controller.isLoading.value && transactions.isEmpty) {
      return CommonLoading();
    }

    if (transactions.isEmpty) {
      return NoDataFound();
    }

    return Expanded(
      child: Stack(
        children: [
          Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    localization.walletDetailsHistory,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      bottom: 50,
                      top: 16,
                    ),
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
                            TransactionDetailsDropDown(
                              transaction: transaction,
                            ),
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
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.10,
                          ),
                          height: 0,
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoadingMore.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(String? amount, int decimals) {
    if (amount == null || amount.isEmpty) return "0.00";
    final parsed = double.tryParse(amount);
    if (parsed == null) return "0.00";
    return parsed.toStringAsFixed(decimals);
  }
}
