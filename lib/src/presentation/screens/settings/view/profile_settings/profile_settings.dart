import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/common/controller/image_picker_controller.dart';
import 'package:qunzo_agent/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_agent/src/common/widgets/button/common_button.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/common_single_date_picker.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/image_picker_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/common/widgets/input_field/common_text_input_field.dart';
import 'package:qunzo_agent/src/presentation/screens/settings/controller/profile_settings_controller.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final ProfileSettingsController controller = Get.find();
  final ImagePickerController imagePickerController = Get.put(
    ImagePickerController(),
  );
  final UserProfileController userProfileController = Get.find();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    final user = userProfileController.userProfileModel.value.data!.user;
    controller.firstNameController.text = user?.firstName ?? "";
    controller.lastNameController.text = user?.lastName ?? "";
    controller.userNameController.text = user?.username ?? "";
    controller.gender.value = user?.gender == "male" ? "Male" : "Female";
    controller.genderController.text = controller.gender.value;
    controller.dateOfBirth.value = user?.dateOfBirth ?? "";
    controller.emailAddressController.text = user?.email ?? "";
    controller.phoneController.text = user?.phone ?? "";
    controller.countryCode.value = user?.country ?? "";
    controller.cityController.text = user?.city ?? "";
    controller.zipCodeController.text = user?.zipCode ?? "";
    controller.addressController.text = user?.address ?? "";
    controller.joiningDateController.text = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(DateTime.parse(user?.createdAt ?? ""));
    await controller.fetchCountries();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        body: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return CommonLoading();
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            keyboardType: TextInputType.name,
                            hintText: localization.profileSettingsFirstNameHint,
                            controller: controller.firstNameController,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            keyboardType: TextInputType.name,
                            hintText: localization.profileSettingsLastNameHint,
                            controller: controller.lastNameController,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            keyboardType: TextInputType.name,
                            hintText: localization.profileSettingsUserNameHint,
                            controller: controller.userNameController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
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
                                      .profileSettingsGenderNotFound,
                                  textController: controller.genderController,
                                  title: localization
                                      .profileSettingsGenderSelectTitle,
                                  dropdownItems: ["Male", "Female"],
                                  selectedItem: controller.gender,
                                  bottomSheetHeight: 400,
                                  currentlySelectedValue:
                                      controller.gender.value,
                                ),
                              );
                            },
                            hintText: localization.profileSettingsGenderHint,
                            controller: controller.genderController,

                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonSingleDatePicker(
                            fillColor: AppColors.transparent,
                            onDateSelected: (DateTime value) {
                              final dateFormat = DateFormat(
                                "dd/MM/yyyy",
                              ).format(value);
                              controller.dateOfBirth.value = dateFormat;
                            },
                            initialDate: controller.dateOfBirth.value.isNotEmpty
                                ? DateTime.tryParse(
                                    controller.dateOfBirth.value,
                                  )
                                : null,
                            hintText:
                                localization.profileSettingsDateOfBirthHint,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            keyboardType: TextInputType.emailAddress,
                            hintText:
                                localization.profileSettingsEmailAddressHint,
                            controller: controller.emailAddressController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            hintText: localization.profileSettingsPhoneHint,
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
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
                                  showSearch: true,
                                  notFoundText: localization
                                      .profileSettingsCountryNotFound,
                                  title: localization
                                      .profileSettingsCountrySelectTitle,
                                  onValueSelected: (value) {
                                    int index = controller.countryList
                                        .indexWhere(
                                          (item) => item.name == value,
                                        );
                                    if (index != -1) {
                                      final selectedCountry =
                                          controller.countryList[index];
                                      controller.countryController.text =
                                          selectedCountry.name ?? "";
                                      controller.countryCode.value =
                                          selectedCountry.code ?? "";
                                    }
                                  },
                                  selectedValue: controller.countryList
                                      .map((item) => item.name.toString())
                                      .toList(),
                                  dropdownItems: controller.countryList
                                      .map((item) => item.name.toString())
                                      .toList(),
                                  selectedItem: controller.country,
                                  textController: controller.countryController,
                                  currentlySelectedValue:
                                      controller.country.value,
                                  bottomSheetHeight: 400,
                                ),
                              );
                            },
                            hintText: localization.profileSettingsCountryHint,
                            controller: controller.countryController,

                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            hintText: localization.profileSettingsCityHint,
                            controller: controller.cityController,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            hintText: localization.profileSettingsZipCodeHint,
                            controller: controller.zipCodeController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            hintText:
                                localization.profileSettingsJoiningDateHint,
                            controller: controller.joiningDateController,
                            keyboardType: TextInputType.datetime,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),
                          CommonTextInputField(
                            backgroundColor: AppColors.transparent,
                            hintText: localization.profileSettingsAddressHint,
                            maxLine: 3,
                            controller: controller.addressController,
                            keyboardType: TextInputType.streetAddress,
                            borderRadius: 8,
                          ),
                          SizedBox(height: 30),
                          CommonButton(
                            onPressed: () => controller.submitUpdateProfile(),
                            width: double.infinity,
                            height: 54,
                            text: localization.profileSettingsSaveChangesButton,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Obx(
              () => Visibility(
                visible: controller.isProfileUpdateLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    final localization = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Image.asset(PngAssets.profileSettingsShape),
        Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      PngAssets.arrowLeftCommonIcon,
                      color: AppColors.white,
                      width: 24,
                    ),
                  ),
                ),
                Spacer(),
                Transform.translate(
                  offset: Offset(-23, 0),
                  child: Text(
                    localization.profileSettingsTitle,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    showImageSourceSheet();
                  },
                  child: Obx(
                    () => Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: imagePickerController.selectedImage.value != null
                            ? DecorationImage(
                                image: FileImage(
                                  imagePickerController.selectedImage.value!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : userProfileController
                                  .userProfileModel
                                  .value
                                  .data!
                                  .user!
                                  .avatar!
                                  .isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  userProfileController
                                      .userProfileModel
                                      .value
                                      .data!
                                      .user!
                                      .avatar!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child:
                          imagePickerController.selectedImage.value == null &&
                              userProfileController
                                  .userProfileModel
                                  .value
                                  .data!
                                  .user!
                                  .avatar!
                                  .isEmpty
                          ? Center(
                              child: Text(
                                "${userProfileController.userProfileModel.value.data!.user!.firstName!.trim().isNotEmpty ? userProfileController.userProfileModel.value.data!.user!.firstName!.trim()[0].toUpperCase() : ''}"
                                "${userProfileController.userProfileModel.value.data!.user!.lastName!.trim().isNotEmpty ? userProfileController.userProfileModel.value.data!.user!.lastName!.trim()[0].toUpperCase() : ''}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                  color: AppColors.lightPrimary,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showImageSourceSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(PngAssets.profileSettingsCameraIcon),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showImageSourceSheet() {
    Get.bottomSheet(ImagePickerDropdownBottomSheet());
  }
}
