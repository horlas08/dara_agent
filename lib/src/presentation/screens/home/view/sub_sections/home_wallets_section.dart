import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_icon_button.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/model/dashboard_model.dart';

class HomeWalletsSection extends StatefulWidget {
  const HomeWalletsSection({super.key});

  @override
  State<HomeWalletsSection> createState() => _HomeWalletsSectionState();
}

class _HomeWalletsSectionState extends State<HomeWalletsSection> {
  final HomeController homeController = Get.find();
  final PageController _pageController = PageController();

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
    final wallets = homeController.dashboardModel.value.data?.wallets ?? [];

    walletImages = List.generate(
      wallets.length,
      (index) => defaultWalletImages[index % defaultWalletImages.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Wallets> wallets =
        homeController.dashboardModel.value.data?.wallets ?? [];
    final localization = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 200.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: wallets.length,
                onPageChanged: (index) {
                  homeController.currentWalletIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final image = walletImages[index];
                  final Wallets wallet = wallets[index];
                  return InkWell(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          overflow: TextOverflow.ellipsis,
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
                                  text: localization.homeWalletsSectionTopUp,
                                  icon: PngAssets.commonTopUpAndWithdrawIcon,
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
                                  text: localization.homeWalletsSectionWithdraw,
                                  icon: PngAssets.commonTopUpAndWithdrawIcon,
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
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(wallets.length, (index) {
                  final bool isActive =
                      homeController.currentWalletIndex.value == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.white
                          : AppColors.lightPrimary.withValues(alpha: 0.24),
                      border: Border.all(
                        color: isActive
                            ? AppColors.lightPrimary
                            : Colors.transparent,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  );
                }),
              );
            }),
          ],
        ),
        Positioned(
          top: 0,
          right: 17.w,
          child: CommonIconButton(
            width: 105.w,
            height: 30.h,
            text: localization.homeWalletsSectionAddWallet,
            icon: PngAssets.addCommonIcon,
            iconWidth: 14.w,
            iconHeight: 14.h,
            iconAndTextSpace: 3.w,
            fontSize: 13.sp,
            onPressed: () {
              Get.toNamed(
                BaseRoute.createNewWallet,
                arguments: {"is_home_wallet": true},
              );
            },
          ),
        ),
      ],
    );
  }
}
