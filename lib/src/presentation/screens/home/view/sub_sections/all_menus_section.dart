import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class AllMenusSection extends StatelessWidget {
  const AllMenusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.find();

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              _buildUserInfoSection(userProfileController, context),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildNavigationOneSection(context),
                      const SizedBox(height: 16),
                      _buildNavigationThreeSection(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: Get.find<HomeController>().isSignOutLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationOneSection(context) {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.myWalletsMenu,
            title: localization.allMenusSectionMyWallets,
            onTap: () => Get.toNamed(
              BaseRoute.wallets,
              arguments: {"is_wallet_main_screen": false},
            ),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.qrCodeMenu,
            title: localization.allMenusSectionQrCode,
            onTap: () => Get.toNamed(BaseRoute.qrCode),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.addMoneyMenu,
            title: localization.allMenusSectionAddMoney,
            onTap: () => Get.toNamed(BaseRoute.addMoney),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.cashInMenu,
            title: localization.allMenusSectionCashIn,
            onTap: () => Get.toNamed(BaseRoute.cashIn),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.exchangeMenu,
            title: localization.allMenusSectionExchange,
            onTap: () => Get.toNamed(BaseRoute.exchange),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.withdrawMoneyMenu,
            title: localization.allMenusSectionWithdrawMoney,
            onTap: () => Get.toNamed(BaseRoute.withdraw),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.profitHistoryMenu,
            title: localization.allMenusSectionProfitHistory,
            onTap: () => Get.toNamed(BaseRoute.profitHistory),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.transactionsMenu,
            title: localization.allMenusSectionTransactions,
            onTap: () => Get.toNamed(
              BaseRoute.transactions,
              arguments: {"is_transaction_main_screen": false},
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavigationThreeSection(context) {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.logOutMenu,
            title: localization.allMenusSectionLogout,
            titleColor: AppColors.error,
            onTap: () => Get.find<HomeController>().submitLogout(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavigation({
    required String icon,
    required String title,
    required GestureTapCallback onTap,
    Color? titleColor,
  }) {
    titleColor ??= AppColors.lightTextPrimary.withValues(alpha: 0.80);

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(icon, width: 26),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Image.asset(
                    PngAssets.arrowRightCommonIcon,
                    width: 22,
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.50),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(left: 57),
            child: Divider(
              height: 0,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection(
    UserProfileController userProfileController,
    context,
  ) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          CommonAppBar(
            title: localization.allMenusSectionTitle,
            horizontalPadding: 0,
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    userProfileController
                        .userProfileModel
                        .value
                        .data!
                        .user!
                        .avatar!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        PngAssets.profileImage,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfileController
                            .userProfileModel
                            .value
                            .data!
                            .user!
                            .username ??
                        "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: userProfileController
                              .userProfileModel
                              .value
                              .data!
                              .user!
                              .accountNumber!,
                        ),
                      );
                      ToastHelper().showSuccessToast(
                        localization.allMenusSectionAccountNumberCopied,
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          localization.allMenusSectionAid(
                            userProfileController
                                .userProfileModel
                                .value
                                .data!
                                .user!
                                .accountNumber!,
                          ),
                          style: TextStyle(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.lightTextTertiary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Color(0xFF1A0721).withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          PngAssets.accountNumberCopyIcon,
                          width: 22,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
