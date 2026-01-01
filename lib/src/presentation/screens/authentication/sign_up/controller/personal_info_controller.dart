import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/model/country_model.dart';
import 'package:qunzo_agent/src/common/model/user_profile_model.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';

class PersonalInfoController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isSubmitLoading = false.obs;
  final Rx<UserProfileModel> userModel = UserProfileModel().obs;
  final RxList<CountryData> countryList = <CountryData>[].obs;

  // First Name
  final firstNameController = TextEditingController();

  // Last Name
  final lastNameController = TextEditingController();

  // User Name
  final userNameController = TextEditingController();

  // Country
  final RxString country = "".obs;
  final RxString countryCode = "".obs;
  final RxString countryDialCode = "".obs;
  final countryController = TextEditingController();

  // Phone No
  final phoneNoController = TextEditingController();

  // Gender
  final RxString gender = "".obs;
  final genderController = TextEditingController();

  // Fetch User
  Future<void> fetchUser() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getUserProfileEndpoint,
      );
      if (response.status == Status.completed) {
        userModel.value = UserProfileModel.fromJson(response.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUser() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }

  // Fetch Countries
  Future<void> fetchCountries() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.countriesEndpoint,
      );
      if (response.status == Status.completed) {
        final countryModel = CountryModel.fromJson(response.data!);
        countryList.clear();
        countryList.value = countryModel.data ?? [];
        final findCountry = countryList.firstWhere(
          (item) => item.code == countryCode.value,
        );
        country.value = findCountry.name ?? "";
        countryController.text = findCountry.name ?? "";
        countryCode.value = findCountry.code ?? "";
        countryDialCode.value = findCountry.dialCode ?? "";
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchCountries() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }

  // Submit Personal Info
  Future<void> submitPersonalInfo() async {
    isSubmitLoading.value = true;
    try {
      final Map<String, dynamic> requestBody = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
      };

      if (userNameController.text.isNotEmpty) {
        requestBody["username"] = userNameController.text;
      }

      if (phoneNoController.text.isNotEmpty) {
        requestBody["phone"] = phoneNoController.text;
      }

      if (countryController.text.isNotEmpty) {
        requestBody["country"] = "$countryDialCode:${countryCode.value}";
      }

      if (genderController.text.isNotEmpty) {
        requestBody["gender"] = gender.value == "Male"
            ? "male"
            : gender.value == "Female"
            ? "female"
            : "other";
      }

      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.personalInfoEndpoint,
        data: requestBody,
      );
      if (response.status == Status.completed) {
        Get.toNamed(
          BaseRoute.signUpStatus,
          arguments: {"is_personal_info": true},
        );
        resetFields();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitPersonalInfo() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isSubmitLoading.value = false;
    }
  }

  void resetFields() {
    // First Name
    firstNameController.clear();

    // Last Name
    lastNameController.clear();

    // User Name
    userNameController.clear();

    // Country
    country.value = "";
    countryCode.value = "";
    countryDialCode.value = "";
    countryController.clear();

    // Phone No
    phoneNoController.clear();

    // Gender
    gender.value = "";
    genderController.clear();
  }
}
