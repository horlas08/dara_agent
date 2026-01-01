import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/model/withdraw_account_model.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/edit_withdraw_account/edit_withdraw_account.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/view/sub_sections/delete_account_drop_down_section.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';

class WithdrawAccountSection extends StatefulWidget {
  const WithdrawAccountSection({super.key});

  @override
  State<WithdrawAccountSection> createState() => _WithdrawAccountSectionState();
}

class _WithdrawAccountSectionState extends State<WithdrawAccountSection>
    with WidgetsBindingObserver {
  final WithdrawAccountController controller = Get.find();
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
      controller.loadMoreWithdrawAccounts();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchWithdrawAccounts();
    controller.isLoading.value = false;
  }

  Future<void> refreshData() async {
    controller.isLoading.value = true;
    await controller.fetchWithdrawAccounts();
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.withdrawAccountSectionTitle,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 20,
                color: AppColors.lightTextPrimary,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    controller.isLoading.value
                        ? CommonLoading()
                        : controller
                              .withdrawAccountModel
                              .value
                              .data!
                              .accounts!
                              .isEmpty
                        ? NoDataFound()
                        : RefreshIndicator(
                            color: AppColors.lightPrimary,
                            onRefresh: () => refreshData(),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.lightTextPrimary
                                            .withValues(alpha: 0.16),
                                      ),
                                    ),
                                    child: ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        final Accounts account = controller
                                            .withdrawAccountModel
                                            .value
                                            .data!
                                            .accounts![index];

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    account.methodName ?? "",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 15,
                                                      color: AppColors
                                                          .lightTextPrimary,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    "${account.walletName} (${account.currency})",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .lightTextTertiary,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                        () =>
                                                            EditWithdrawAccount(
                                                              account: account,
                                                            ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        8,
                                                      ),
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                        color: AppColors
                                                            .lightPrimary,
                                                      ),
                                                      child: Image.asset(
                                                        PngAssets
                                                            .withdrawEditIcon,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  GestureDetector(
                                                    onTap: () => Get.bottomSheet(
                                                      DeleteAccountDropdownSection(
                                                        accountId: account.id
                                                            .toString(),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        8,
                                                      ),
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                        color: AppColors.error,
                                                      ),
                                                      child: Image.asset(
                                                        PngAssets
                                                            .deleteCommonIcon,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Column(
                                            children: [
                                              const SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      AppColors.lightPrimary
                                                          .withValues(alpha: 0),
                                                      AppColors.lightPrimary,
                                                      AppColors.lightPrimary
                                                          .withValues(alpha: 0),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                            ],
                                          ),
                                      itemCount: controller
                                          .withdrawAccountModel
                                          .value
                                          .data!
                                          .accounts!
                                          .length,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
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
          ],
        ),
      ),
    );
  }
}
