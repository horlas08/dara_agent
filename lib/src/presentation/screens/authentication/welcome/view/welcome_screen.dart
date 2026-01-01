import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_alert_bottom_sheet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PngAssets.welcomeScreenFream),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: deviceHeight / 1.85),
                    Image.asset(PngAssets.appLogo, width: 120),
                    SizedBox(height: 30),
                    Text(
                      localization.welcomeScreenTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      localization.welcomeScreenDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.lightTextTertiary,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 60),
                    CommonButton(
                      onPressed: () => Get.toNamed(BaseRoute.email),
                      text: localization.welcomeScreenCreateAccount,
                    ),
                    SizedBox(height: 16),
                    CommonButton(
                      onPressed: () => Get.toNamed(BaseRoute.signIn),
                      text: localization.welcomeScreenLogin,
                      textColor: AppColors.lightTextPrimary,
                      backgroundColor: AppColors.lightPrimary.withValues(
                        alpha: 0.16,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
