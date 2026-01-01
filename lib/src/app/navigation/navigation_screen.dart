import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/svg_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/home_screen.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/view/settings_screen.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/view/transactions_screen.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/view/wallets_screen.dart';
import 'package:qunzo_agent/src/presentation/widgets/qr_scanner_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.find<HomeController>();
  late List<Widget> pageStacks;

  final iconList = [
    SvgAssets.homeBottomSheetIcon,
    SvgAssets.walletsBottomSheetIcon,
    SvgAssets.transactionsBottomSheetIcon,
    SvgAssets.settingsBottomSheetIcon,
  ];

  @override
  void initState() {
    super.initState();
    homeController.setScaffoldKey(_scaffoldKey);

    pageStacks = [
      HomeScreen(),
      WalletsScreen(isWalletMainScreen: true),
      TransactionsScreen(isTransactionMainScreen: true),
      SettingsScreen(isSettingsMainScreen: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final labelList = [
      localization.agentNavigationBottomNavHome,
      localization.agentNavigationBottomNavWallets,
      localization.agentNavigationBottomNavTransactions,
      localization.agentNavigationBottomNavSettings,
    ];

    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        body: pageStacks[homeController.selectedIndex.value],
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          backgroundColor: AppColors.lightPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: SvgPicture.asset(
            SvgAssets.qrScannerBottomSheetIcon,
            width: 30,
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
          onPressed: () async {
            final scannedCode = await Get.to(() => const QrScannerScreen());

            if (scannedCode != null) {
              final uidMatch = RegExp(
                r'^UID\s*:\s*(\d+)$',
                caseSensitive: false,
              ).firstMatch(scannedCode.trim());

              if (uidMatch != null) {
                final uid = uidMatch.group(1);
                Get.toNamed(BaseRoute.cashIn, arguments: {"uid_account": uid});
                return;
              }

              final isNumeric = RegExp(r'^\d+$').hasMatch(scannedCode.trim());
              if (!isNumeric) {
                ToastHelper().showErrorToast(
                  localization.agentNavigationQrInvalidFormat,
                );
              }
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 90,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive
                ? AppColors.lightPrimary
                : AppColors.lightTextPrimary.withValues(alpha: 0.30);

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconList[index],
                  width: 30,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(height: 2),
                Text(
                  labelList[index],
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.visible,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
          backgroundColor: AppColors.white,
          activeIndex: homeController.selectedIndex.value,
          gapLocation: GapLocation.center,
          onTap: (index) {
            homeController.selectedIndex.value = index;
          },
          shadow: BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 40,
            spreadRadius: 0,
            color: AppColors.black.withValues(alpha: 0.10),
          ),
        ),
      ),
    );
  }
}
