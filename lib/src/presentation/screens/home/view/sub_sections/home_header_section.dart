import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/all_menus_section.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.find();
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.lightPrimary.withValues(alpha: 0),
            AppColors.lightPrimary.withValues(alpha: 0.16),
          ],
          stops: [0.1, 0.95],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(BaseRoute.profileSettings);
                      },
                      child: SizedBox(
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
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProfileController
                                    .userProfileModel
                                    .value
                                    .data
                                    ?.user
                                    ?.greetings ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.lightTextTertiary,
                            ),
                          ),
                          const SizedBox(height: 4),
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
                              fontSize: 22,
                              color: AppColors.lightTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AllMenusSection());
                },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(PngAssets.hambergerMenu, width: 20),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.toNamed(BaseRoute.notification),
                child: Container(
                  padding: const EdgeInsets.all(13),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Transform.translate(
                    offset: const Offset(-3, 0),
                    child: Badge(
                      backgroundColor: AppColors.lightPrimary,
                      smallSize:
                          userProfileController
                                  .userProfileModel
                                  .value
                                  .data
                                  ?.user
                                  ?.unreadNotificationsCount !=
                              0
                          ? 7
                          : 0,
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: const Offset(5.5, 0),
                        child: Image.asset(PngAssets.notificationCommonIcon),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
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
                  localization.homeHeaderSectionAccountNumberCopied,
                );
              },
              child: Row(
                children: [
                  Text(
                    localization.homeHeaderSectionAid(
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
                      fontSize: 16,
                      color: AppColors.lightTextPrimary,
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
                  Image.asset(PngAssets.accountNumberCopyIcon, width: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
