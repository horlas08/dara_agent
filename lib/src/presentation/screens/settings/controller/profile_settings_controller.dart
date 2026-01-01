import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/common/controller/image_picker_controller.dart';
import 'package:qunzo_agent/src/common/model/country_model.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';

class ProfileSettingsController extends GetxController {
  // Global
  final RxBool isLoading = false.obs;
  final RxBool isProfileUpdateLoading = false.obs;
  final ImagePickerController imagePickerController = Get.put(
    ImagePickerController(),
  );
  final TokenService tokenService = Get.find<TokenService>();

  // First Name
  final firstNameController = TextEditingController();

  // Last Name
  final lastNameController = TextEditingController();

  // User Name
  final userNameController = TextEditingController();

  // Gender
  final RxString gender = "".obs;
  final genderController = TextEditingController();

  // Date Of Birth
  final RxString dateOfBirth = "".obs;

  // Email Address
  final emailAddressController = TextEditingController();

  // Phone
  final phoneController = TextEditingController();

  // Country
  final RxString country = "".obs;
  final RxString countryCode = "".obs;
  final countryController = TextEditingController();
  final RxList<CountryData> countryList = <CountryData>[].obs;

  // City
  final cityController = TextEditingController();

  // Zip Code
  final zipCodeController = TextEditingController();

  // Address
  final addressController = TextEditingController();

  // Joining Date
  final joiningDateController = TextEditingController();

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
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchCountries() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }

  Future<void> submitUpdateProfile() async {
    isProfileUpdateLoading.value = true;
    try {
      final dioInstance = dio.Dio();
      final imageFile = imagePickerController.selectedImage.value;

      String formattedDob;
      try {
        formattedDob = DateFormat(
          "yyyy-MM-dd",
        ).format(DateFormat("dd/MM/yyyy").parse(dateOfBirth.value));
      } catch (e) {
        formattedDob = dateOfBirth.value;
      }
      final formData = dio.FormData.fromMap({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'username': userNameController.text,
        'gender': gender.value == "Male" ? "male" : "female",
        if (dateOfBirth.isNotEmpty) 'date_of_birth': formattedDob,
        'email': emailAddressController.text,
        'phone': phoneController.text,
        'country': countryCode.value,
        'city': cityController.text,
        'zip_code': zipCodeController.text,
        'address': addressController.text,
        if (imageFile != null)
          'avatar': await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });
      final response = await dioInstance.post(
        "${ApiPath.baseUrl}${ApiPath.updateProfileEndpoint}",
        data: formData,
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${tokenService.accessToken.value}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ToastHelper().showSuccessToast(response.data["message"]);
        Get.back();
      }
    } on dio.DioException catch (e) {
      ToastHelper().showErrorToast(e.response!.data["message"]);
    } catch (e, stackTrace) {
      debugPrint('❌ submitUpdateProfile() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isProfileUpdateLoading.value = false;
    }
  }
}
