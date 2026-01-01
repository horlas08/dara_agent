import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/controller/create_new_wallet_controller.dart';

class CreateNewWallet extends StatefulWidget {
  const CreateNewWallet({super.key});

  @override
  State<CreateNewWallet> createState() => _CreateNewWalletState();
}

class _CreateNewWalletState extends State<CreateNewWallet> {
  final CreateNewWalletController controller = Get.find();
  final bool isHomeWallet = Get.arguments?["is_home_wallet"] ?? false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              CommonAppBar(title: localization.createNewWalletTitle),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? CommonLoading(isColorShow: false)
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              CommonTextInputField(
                                backgroundColor: AppColors.transparent,
                                controller: controller.currencyController,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 14,
                                  ),
                                  child: Image.asset(
                                    PngAssets.arrowDownCommonIcon,
                                    width: 10,
                                  ),
                                ),
                                onTap: () {
                                  Get.bottomSheet(
                                    CommonDropdownBottomSheet(
                                      isShowTitle: false,
                                      notFoundText: localization
                                          .createNewWalletCurrencyNotFound,
                                      title: localization
                                          .createNewWalletCurrencyTitle,

                                      onValueSelected: (value) {
                                        controller.currencyId.value = value;
                                      },
                                      selectedValue: controller.currenciesList
                                          .map((item) => item.id.toString())
                                          .toList(),
                                      dropdownItems: controller.currenciesList
                                          .map((item) => item.fullName!)
                                          .toList(),
                                      selectedItem: controller.currency,
                                      textController:
                                          controller.currencyController,
                                      currentlySelectedValue:
                                          controller.currency.value,
                                      bottomSheetHeight: 400,
                                    ),
                                  );
                                },
                                readOnly: true,
                                hintText:
                                    localization.createNewWalletCurrencyHint,
                              ),
                              SizedBox(height: 40),
                              CommonButton(
                                onPressed: () async {
                                  if (isHomeWallet == true) {
                                    await controller.createWallet();
                                    await Get.find<HomeController>().loadData();
                                  } else {
                                    await controller.createWallet();
                                  }
                                },
                                width: double.infinity,
                                text: localization.createNewWalletCreateButton,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isCreateWalletLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
