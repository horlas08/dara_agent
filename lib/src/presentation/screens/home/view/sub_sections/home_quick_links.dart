import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class HomeQuickLinks extends StatefulWidget {
  const HomeQuickLinks({super.key});

  @override
  State<HomeQuickLinks> createState() => _HomeQuickLinksState();
}

class _HomeQuickLinksState extends State<HomeQuickLinks> {
  final HomeController homeController = Get.find();
  final SettingsService settings = Get.find();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final localization = AppLocalizations.of(Get.context!)!;
  late final List<Map<String, String>> serviceList;

  @override
  void initState() {
    super.initState();
    serviceList = [
      {
        "title": localization.homeQuickLinksQrCode,
        "icon": PngAssets.qrCodeService,
        "navigate": BaseRoute.qrCode,
      },
      {
        "title": localization.homeQuickLinksMyWallets,
        "icon": PngAssets.walletsService,
        "navigate": BaseRoute.wallets,
      },
      {
        "title": localization.homeQuickLinksAddMoney,
        "icon": PngAssets.addMoneyService,
        "navigate": BaseRoute.addMoney,
      },
      {
        "title": localization.homeQuickLinksCashIn,
        "icon": PngAssets.cashInService,
        "navigate": BaseRoute.cashIn,
      },
      {
        "title": localization.homeQuickLinksWithdrawMoney,
        "icon": PngAssets.withdrawService,
        "navigate": BaseRoute.withdraw,
      },
      {
        "title": localization.homeQuickLinksProfitHistory,
        "icon": PngAssets.profitService,
        "navigate": BaseRoute.profitHistory,
      },
      {
        "title": localization.homeQuickLinksTransactions,
        "icon": PngAssets.transactionService,
        "navigate": BaseRoute.transactions,
      },
      {
        "title": localization.homeQuickLinksSupport,
        "icon": PngAssets.supportService,
        "navigate": BaseRoute.support,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final int itemsPerPage = 8;
    final int pageCount = (serviceList.length / itemsPerPage).ceil();

    final pages = List.generate(pageCount, (index) {
      final start = index * itemsPerPage;
      final end = (start + itemsPerPage < serviceList.length)
          ? start + itemsPerPage
          : serviceList.length;
      return serviceList.sublist(start, end);
    });

    final rows = ((pages.first.length) / 4).ceil();
    final double dynamicHeight = rows * 90.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            localization.homeQuickLinksTitle,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              fontSize: 20,
              color: AppColors.lightTextPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightPrimary.withValues(alpha: 0.06),
          ),
          child: Column(
            children: [
              SizedBox(
                height: dynamicHeight,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, pageIndex) {
                    final pageItems = pages[pageIndex];
                    return GridView.builder(
                      itemCount: pageItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        final item = pageItems[index];
                        final title = item["title"]!;
                        final route = item["navigate"] ?? '';

                        return GestureDetector(
                          onTap: () {
                            switch (title) {
                              default:
                                if (route.isNotEmpty) Get.toNamed(route);
                                break;
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(item["icon"]!, width: 35),
                              const SizedBox(height: 8),
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.lightTextTertiary,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (serviceList.length > 8) ...[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 6,
                width: _currentPage == index ? 16 : 6,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.lightPrimary
                      : AppColors.lightPrimary.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
