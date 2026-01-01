import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/two_fa_authentication_controller.dart';

class GenerateQrCodeSection extends StatelessWidget {
  const GenerateQrCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TwoFaAuthenticationController controller = Get.find();
    final localization = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF3F3F3),
      ),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(18),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.lightTextTertiary.withValues(alpha: 0.1),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.security,
                      color: AppColors.lightPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      localization.generateQrCodeTitle,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                localization.generateQrCodeDescription,
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.lightTextTertiary,
                ),
              ),
              const SizedBox(height: 24),
              CommonButton(
                onPressed: controller.loadGenerate2Fa,
                width: double.infinity,
                text: localization.generateQrCodeGenerateButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
