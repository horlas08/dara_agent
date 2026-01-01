import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/wallets_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/view/sub_sections/delete_wallet_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';

class WalletsScreen extends StatefulWidget {
  final bool? isWalletMainScreen;

  const WalletsScreen({super.key, this.isWalletMainScreen = false});

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final WalletsController controller = Get.put(WalletsController());
  final HomeController homeController = Get.find();
  final bool isWalletMainScreen =
      (Get.arguments != null && Get.arguments is Map<String, dynamic>)
      ? Get.arguments["is_wallet_main_screen"] ?? false
      : false;

  final List<String> defaultWalletImages = [
    PngAssets.walletOne,
    PngAssets.walletTwo,
    PngAssets.walletThree,
    PngAssets.walletFour,
  ];

  List<String> walletImages = [];

  @override
  void initState() {
    super.initState();
    final shuffled = List<String>.from(defaultWalletImages)..shuffle();
    walletImages = List.generate(controller.walletsList.length, (index) {
      final image = shuffled[index % shuffled.length];
      return image;
    });
  }

  Future<void> _handleBackNavigation() async {
    if (widget.isWalletMainScreen == true || isWalletMainScreen == true) {
      if (homeController.selectedIndex.value == 0) {
        Get.back();
      } else if (homeController.selectedIndex.value == 1) {
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
        body: Column(
          children: [
            SizedBox(height: 16.h),
            isWalletMainScreen == true || widget.isWalletMainScreen == true
                ? CommonAppBar(
                    title: localization.walletsTitle,
                    showRightSideWidget: true,
                    rightSideWidget: GestureDetector(
                      onTap: () => Get.toNamed(BaseRoute.createNewWallet),
                      child: Image.asset(
                        PngAssets.addCommonIconTwo,
                        width: 24.w,
                      ),
                    ),
                    selectedIndex: 0,
                    isBackLogicApply: true,
                    backLogicFunction: () async {
                      Get.back();
                    },
                  )
                : CommonAppBar(
                    title: localization.walletsTitle,
                    showRightSideWidget: true,
                    rightSideWidget: GestureDetector(
                      onTap: () => Get.toNamed(BaseRoute.createNewWallet),
                      child: Image.asset(
                        PngAssets.addCommonIconTwo,
                        width: 24.w,
                      ),
                    ),
                    isBackLogicApply: true,
                    backLogicFunction: () async {
                      Get.back();
                    },
                  ),
            SizedBox(height: 30.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return CommonLoading();
                }

                final wallets = controller.walletsList;
                final walletImages = List.generate(
                  wallets.length,
                  (index) =>
                      defaultWalletImages[index % defaultWalletImages.length],
                );

                if (wallets.isEmpty) {
                  return NoDataFound();
                }

                return RefreshIndicator(
                  color: AppColors.lightPrimary,
                  onRefresh: () => controller.fetchWallets(),
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 50.h),
                    itemCount: wallets.length,
                    itemBuilder: (context, index) {
                      final wallet = wallets[index];
                      final image = walletImages[index];
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                BaseRoute.walletsDetails,
                                arguments: {
                                  "wallet_id": wallet.id,
                                  "wallet_image": image,
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 200.h,
                              margin: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18.w,
                                  top: 18.h,
                                  bottom: 18.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 180.w,
                                              child: Text(
                                                wallet.name ?? "",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 22.sp,
                                                  color: AppColors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  letterSpacing: 0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              wallet.symbol ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 22.sp,
                                                color: AppColors.white,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          wallet.code ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                            color: AppColors.white,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          "${wallet.symbol}${wallet.formattedBalance}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24.sp,
                                            color: AppColors.white,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CommonIconButton(
                                          onPressed: () => Get.toNamed(
                                            BaseRoute.addMoney,
                                            arguments: {
                                              "wallet_id": wallet.id.toString(),
                                            },
                                          ),
                                          width: 85.w,
                                          height: 28.h,
                                          text: localization.walletsTopUp,
                                          icon: PngAssets
                                              .commonTopUpAndWithdrawIcon,
                                          iconWidth: 18.w,
                                          iconHeight: 18.h,
                                          iconAndTextSpace: 5.w,
                                          fontSize: 13.sp,
                                          backgroundColor: AppColors.white,
                                          textColor: AppColors.lightTextPrimary,
                                          iconColor: AppColors.lightTextPrimary,
                                        ),
                                        SizedBox(width: 16.w),
                                        CommonIconButton(
                                          onPressed: () =>
                                              Get.toNamed(BaseRoute.withdraw),
                                          width: 105.w,
                                          height: 28.h,
                                          text: localization.walletsWithdraw,
                                          icon: PngAssets
                                              .commonTopUpAndWithdrawIcon,
                                          iconWidth: 18.w,
                                          iconHeight: 18.w,
                                          iconAndTextSpace: 5.w,
                                          fontSize: 13.sp,
                                          backgroundColor: AppColors.white,
                                          textColor: AppColors.lightTextPrimary,
                                          iconColor: AppColors.lightTextPrimary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: wallet.isDefault == false,
                            child: Positioned(
                              top: 0,
                              right: 17.w,
                              child: CommonIconButton(
                                backgroundColor: AppColors.error,
                                width: 105.w,
                                height: 30.h,
                                text: localization.walletsDelete,
                                icon: PngAssets.deleteCommonIcon,
                                iconWidth: 16.w,
                                iconHeight: 16.h,
                                iconAndTextSpace: 3.w,
                                fontSize: 13.sp,
                                onPressed: () {
                                  Get.bottomSheet(
                                    DeleteWalletBottomSheet(
                                      walletId: wallet.id.toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
