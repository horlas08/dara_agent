import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/presentation/screens/withdraw/controller/withdraw_account_controller.dart';

class DeleteAccountDropdownSection extends StatelessWidget {
  final String accountId;

  const DeleteAccountDropdownSection({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 40),
            Image.asset(PngAssets.walletDeleteIcon, width: 70),
            SizedBox(height: 16),
            Text(
              localization.deleteAccountTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                color: AppColors.lightTextPrimary,
                letterSpacing: 0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              localization.deleteAccountMessage,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CommonButton(
                width: double.infinity,
                height: 54,
                text: localization.deleteAccountConfirmButton,
                onPressed: () async {
                  Get.back();
                  await Get.find<WithdrawAccountController>()
                      .deleteWithdrawAccount(accountId);
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
