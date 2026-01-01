import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/controller/country_controller.dart';
import 'package:qunzo_agent/src/common/controller/register_fields_controller.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_country_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_auth_text_input_field.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/authentication/sign_up/controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final bool isPersonalInfoEdit =
      Get.arguments?["is_personal_info_edit"] ?? false;
  final PersonalInfoController controller = Get.find();
  final CountryController countryController = Get.find<CountryController>();
  final RegisterFieldsController registerFieldsController =
      Get.find<RegisterFieldsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isPersonalInfoEdit == true) {
        loadPersonalData();
      } else {
        loadData();
      }
    });
  }

  Future<void> loadPersonalData() async {
    controller.isLoading.value = true;
    await controller.fetchUser();
    await registerFieldsController.fetchRegisterFields();
    final user = controller.userModel.value.data?.user;
    controller.firstNameController.text = user?.firstName ?? "";
    controller.lastNameController.text = user?.lastName ?? "";
    controller.userNameController.text = user?.username ?? "";
    controller.gender.value = user?.gender == "male"
        ? "Male"
        : user?.gender == "female"
        ? "Female"
        : "Other";
    controller.genderController.text = controller.gender.value;
    controller.phoneNoController.text = user?.phone ?? "";
    controller.countryCode.value = user?.country ?? "";
    await controller.fetchCountries();
    controller.isLoading.value = false;
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await registerFieldsController.fetchRegisterFields();
    if (registerFieldsController.registerFields["agent_country_show"] == "1") {
      await countryController.fetchCountries();
      _setSelectedCountry();
    }
    controller.isLoading.value = false;
  }

  void _setSelectedCountry() {
    final selectedCountry = countryController.countryList.firstWhereOrNull(
      (country) => country.selected == true,
    );

    if (selectedCountry != null) {
      controller.countryController.text = selectedCountry.name ?? "";
      controller.countryCode.value = selectedCountry.code ?? "";
      controller.countryDialCode.value = selectedCountry.dialCode ?? "";
      controller.country.value = selectedCountry.name ?? "";
      controller.phoneNoController.text = selectedCountry.dialCode ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? CommonLoading()
            : Stack(
                children: [
                  Image.asset(PngAssets.authTopShape),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      alignment: Alignment.centerRight,
                      PngAssets.authRightSideShape,
                      width: 250,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(PngAssets.appLogo, width: 80),
                        const SizedBox(height: 20),
                        Text(
                          localization.personalInfoTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.lightPrimary.withValues(alpha: 0),
                                AppColors.lightPrimary,
                                AppColors.lightPrimary.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 220,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.lightPrimary.withValues(alpha: 0),
                                AppColors.lightPrimary.withValues(alpha: 0.15),
                                AppColors.lightPrimary.withValues(alpha: 0),
                              ],
                            ),
                          ),
                          child: Text(
                            localization.personalInfoSubtitle,
                            style: TextStyle(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: AppColors.lightTextPrimary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                CommonAuthTextInputField(
                                  isRequired: true,
                                  controller: controller.firstNameController,
                                  keyboardType: TextInputType.name,
                                  labelText: localization.personalInfoFirstName,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          PngAssets.commonAuthNameIcon,
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.80),
                                          width: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 16,
                                          width: 2,
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CommonAuthTextInputField(
                                  isRequired: true,
                                  controller: controller.lastNameController,
                                  keyboardType: TextInputType.name,
                                  labelText: localization.personalInfoLastName,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          PngAssets.commonAuthNameIcon,
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.80),
                                          width: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 16,
                                          width: 2,
                                          color: AppColors.lightTextPrimary
                                              .withValues(alpha: 0.20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["agent_username_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                      .registerFields["agent_username_validation"] ==
                                                  "1"
                                              ? true
                                              : false,
                                          controller:
                                              controller.userNameController,
                                          keyboardType: TextInputType.name,
                                          labelText:
                                              localization.personalInfoUsername,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  PngAssets
                                                      .commonAuthUsernameIcon,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.80),
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 16,
                                                  width: 2,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["agent_country_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                      .registerFields["agent_country_validation"] ==
                                                  "1"
                                              ? true
                                              : false,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 14,
                                              right: 14,
                                            ),
                                            child: Image.asset(
                                              PngAssets.arrowDownCommonIcon,
                                              width: 10,
                                            ),
                                          ),
                                          controller:
                                              controller.countryController,
                                          keyboardType: TextInputType.none,
                                          readOnly: true,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  PngAssets
                                                      .commonAuthCountryIcon,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.80),
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 16,
                                                  width: 2,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Get.bottomSheet(
                                              CommonCountryDropdownBottomSheet(
                                                clearFunction: () {
                                                  controller.phoneNoController
                                                      .clear();
                                                  controller
                                                      .phoneNoController
                                                      .text = controller
                                                      .countryDialCode
                                                      .value;
                                                },
                                                countryDialCode:
                                                    countryController
                                                        .countryList
                                                        .map(
                                                          (item) =>
                                                              item.dialCode ??
                                                              "",
                                                        )
                                                        .toList(),
                                                controller: controller,
                                                countryCode: countryController
                                                    .countryList
                                                    .map(
                                                      (item) => item.code ?? "",
                                                    )
                                                    .toList(),
                                                countryImage: countryController
                                                    .countryList
                                                    .map(
                                                      (item) => item.flag ?? "",
                                                    )
                                                    .toList(),
                                                title: localization
                                                    .personalInfoSelectCountry,
                                                dropdownItems: countryController
                                                    .countryList
                                                    .map(
                                                      (item) => item.name ?? "",
                                                    )
                                                    .toList(),
                                                selectedItem:
                                                    controller.country,
                                                textController: controller
                                                    .countryController,
                                                bottomSheetHeight: 450,
                                              ),
                                            );
                                          },
                                          labelText: localization
                                              .personalInfoDropdownSelectCountry,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["agent_phone_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                      .registerFields["agent_phone_validation"] ==
                                                  "1"
                                              ? true
                                              : false,
                                          controller:
                                              controller.phoneNoController,
                                          labelText:
                                              localization.personalInfoPhone,
                                          keyboardType: TextInputType.phone,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  PngAssets.commonAuthPhoneIcon,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.80),
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 16,
                                                  width: 2,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["agent_gender_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                      .registerFields["agent_gender_validation"] ==
                                                  "1"
                                              ? true
                                              : false,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 10,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  PngAssets
                                                      .commonAuthGenderIcon,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.80),
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 16,
                                                  width: 2,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 14,
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
                                                notFoundText: localization
                                                    .personalInfoDropdownGenderNotFound,
                                                textController:
                                                    controller.genderController,
                                                title: localization
                                                    .personalInfoSelectGender,
                                                dropdownItems: [
                                                  "Male",
                                                  "Female",
                                                  "Other",
                                                ],
                                                selectedItem: controller.gender,
                                                bottomSheetHeight: 400,
                                                currentlySelectedValue:
                                                    controller.gender.value,
                                              ),
                                            );
                                          },
                                          labelText: localization
                                              .personalInfoDropdownSelectGender,
                                          controller:
                                              controller.genderController,
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                CommonButton(
                                  onPressed: () => validateFields(),
                                  width: double.infinity,
                                  height: 54,
                                  text: localization.personalInfoSubmitButton,
                                ),
                                const SizedBox(height: 16),
                                CommonButton(
                                  text: localization.personalInfoBackButton,
                                  onPressed: () => Get.back(),
                                  backgroundColor: AppColors.lightPrimary
                                      .withValues(alpha: 0.16),
                                  textColor: AppColors.lightTextPrimary,
                                ),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isSubmitLoading.value,
                      child: CommonLoading(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void validateFields() async {
    final localization = AppLocalizations.of(context)!;
    final validations = [
      _ValidationCheck(
        condition: controller.firstNameController.text.isEmpty,
        errorMessage: localization.personalInfoFirstNameRequired,
      ),
      _ValidationCheck(
        condition: controller.lastNameController.text.isEmpty,
        errorMessage: localization.personalInfoLastNameRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["agent_username_validation"] ==
                "1" &&
            controller.userNameController.text.isEmpty,
        errorMessage: localization.personalInfoUsernameRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["agent_country_validation"] ==
                "1" &&
            controller.countryController.text.isEmpty,
        errorMessage: localization.personalInfoCountryRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController.registerFields["agent_phone_validation"] ==
                "1" &&
            controller.phoneNoController.text.isEmpty,
        errorMessage: localization.personalInfoPhoneRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["agent_gender_validation"] ==
                "1" &&
            controller.genderController.text.isEmpty,
        errorMessage: localization.personalInfoGenderRequired,
      ),
    ];

    for (final validation in validations) {
      if (validation.condition) {
        ToastHelper().showErrorToast(validation.errorMessage);
        return;
      }
    }

    await controller.submitPersonalInfo();
  }
}

class _ValidationCheck {
  final bool condition;
  final String errorMessage;

  _ValidationCheck({required this.condition, required this.errorMessage});
}
