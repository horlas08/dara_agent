import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_alert_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_header_section.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_quick_links.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_skeleton_loader.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_transaction_section.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_wallets_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    homeController.currentWalletIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.bottomSheet(
          CommonAlertBottomSheet(
            title: localization.commonAlertExitTitle,
            message: localization.commonAlertExitMessage,
            onConfirm: () => exit(0),
            onCancel: () => Get.back(),
          ),
        );
      },
      child: Scaffold(
        body: Obx(() {
          if (homeController.isLoading.value) {
            return HomeSkeletonLoader();
          }
          return RefreshIndicator(
            color: AppColors.lightPrimary,
            onRefresh: () => homeController.loadData(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HomeHeaderSection(),
                  const SizedBox(height: 30),
                  HomeWalletsSection(),
                  const SizedBox(height: 30),
                  HomeQuickLinks(),
                  const SizedBox(height: 30),
                  _buildSectionHeader(),
                  const SizedBox(height: 16),
                  HomeTransactionSection(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader() {
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localization.homeScreenTransactionHistory,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              fontSize: 20,
              color: AppColors.lightTextPrimary,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(
              BaseRoute.transactions,
              arguments: {"is_transaction_main_screen": false},
            ),
            child: Text(
              localization.homeScreenSeeAll,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                fontSize: 17,
                color: AppColors.lightPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
