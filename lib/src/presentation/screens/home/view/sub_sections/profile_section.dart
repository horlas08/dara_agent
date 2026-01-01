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

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.find();

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: CommonDefaultAppBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              _buildProfileSection(userProfileController),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildNavigationOneSection(
                        userProfileController,
                        context,
                      ),
                      const SizedBox(height: 16),
                      _buildNavigationTwoSection(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Image.asset(PngAssets.bottomScreenShape, fit: BoxFit.cover),
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

  Widget _buildNavigationOneSection(
    UserProfileController userProfileController,
    context,
  ) {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.myWalletsMenu,
            title: localization.profileSectionAccountNumberDisplay(
              userProfileController
                  .userProfileModel
                  .value
                  .data!
                  .user!
                  .accountNumber!,
            ),
            rightSideIcon: PngAssets.accountNumberCopyIcon,
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
                localization.profileSectionAccountNumberCopied,
              );
            },
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.profileSettingsMenu,
            title: localization.profileSectionProfileSettings,
            onTap: () => Get.toNamed(BaseRoute.profileSettings),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.changePasswordMenu,
            title: localization.profileSectionChangePassword,
            onTap: () => Get.toNamed(BaseRoute.changePassword),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.notificationsMenu,
            title: localization.profileSectionNotifications,
            onTap: () => Get.toNamed(BaseRoute.notification),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.supportTicketsMenu,
            title: localization.profileSectionSupportTickets,
            onTap: () => Get.toNamed(BaseRoute.support),
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
    String rightSideIcon = PngAssets.arrowRightCommonIcon,
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
                    rightSideIcon,
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

  Widget _buildNavigationTwoSection(context) {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.logOutMenu,
            title: localization.profileSectionLogout,
            titleColor: AppColors.error,
            onTap: () => Get.find<HomeController>().submitLogout(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileSection(UserProfileController userProfileController) {
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          CommonAppBar(),
          const SizedBox(height: 20),
          SizedBox(
            width: 90,
            height: 90,
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
                  return Image.asset(PngAssets.profileImage, fit: BoxFit.cover);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            userProfileController.userProfileModel.value.data!.user!.fullName ??
                "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w900,
              fontSize: 25,
              color: AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "@${userProfileController.userProfileModel.value.data!.user!.username ?? ""}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
