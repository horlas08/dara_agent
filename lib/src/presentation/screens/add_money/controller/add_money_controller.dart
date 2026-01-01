import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';
import 'package:qunzo_agent/src/presentation/screens/add_money/model/gateway_methods_model.dart';
import 'package:qunzo_agent/src/presentation/screens/wallets/model/wallets_model.dart';
import 'package:qunzo_agent/src/presentation/widgets/web_view_screen.dart';

class AddMoneyController extends GetxController {
  // Global Variables
  final RxBool isLoading = false.obs;
  final RxBool isGatewayMethodsLoading = false.obs;
  final RxBool isPaymentLoading = false.obs;
  final TokenService tokenService = Get.find<TokenService>();
  final RxInt currentStep = 0.obs;
  final List<String> steps = ['Amount', 'Review', 'Success'];
  final ImagePicker _picker = ImagePicker();
  final Rxn<Map<String, dynamic>> successPaymentData =
      Rxn<Map<String, dynamic>>();
  final Rxn<Map<String, dynamic>> pendingPaymentData =
      Rxn<Map<String, dynamic>>();
  final localization = AppLocalizations.of(Get.context!)!;

  // Wallet
  final RxString wallet = "".obs;
  final RxString walletId = "".obs;
  final RxString currencyCode = "".obs;
  final RxBool isDefaultWallet = false.obs;
  final RxBool isCrypto = false.obs;
  final walletController = TextEditingController();
  final RxList<Wallets> walletsList = <Wallets>[].obs;

  // Gateway
  final RxString gateway = "".obs;
  final RxString gatewayId = "".obs;
  final RxDouble charge = 0.0.obs;
  final RxString chargeType = "".obs;
  final RxDouble minimumDeposit = 0.0.obs;
  final RxDouble maximumDeposit = 0.0.obs;
  final RxString gatewayType = "".obs;
  final RxString gatewayCurrency = "".obs;
  final RxString gatewayInstructions = "".obs;
  final RxString gatewayCurrencyType = "".obs;
  final RxInt currencyDecimals = 0.obs;
  final gatewayController = TextEditingController();
  final RxList<GatewayMethodsData> gatewayMethodsList =
      <GatewayMethodsData>[].obs;
  final RxMap<String, Map<String, dynamic>> dynamicFieldControllers =
      <String, Map<String, dynamic>>{}.obs;

  // Selected Images
  final RxMap<String, File?> selectedImages = <String, File?>{}.obs;

  // Amount
  final amountController = TextEditingController();

  // Review Amounts
  final RxDouble baseAmount = 0.0.obs;
  final RxDouble calculatedCharge = 0.0.obs;
  final RxDouble totalAmount = 0.0.obs;

  // Fetch Wallets
  Future<void> fetchWallets() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.walletsEndpoint,
      );

      if (response.status == Status.completed) {
        final walletsModel = WalletsModel.fromJson(response.data!);
        walletsList.clear();
        walletsList.value = walletsModel.data!.wallets ?? [];
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchWallets() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {}
  }

  // Fetch Gateway Methods
  Future<void> fetchGatewayMethods({bool? idFindGateway = false}) async {
    idFindGateway == true
        ? isLoading.value = true
        : isGatewayMethodsLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: "${ApiPath.getGatewayMethodsEndpoint}?currency=$currencyCode",
      );
      if (response.status == Status.completed) {
        final gatewayMethodsModel = GatewayMethodsModel.fromJson(
          response.data!,
        );
        gatewayMethodsList.clear();
        gatewayMethodsList.assignAll(gatewayMethodsModel.data!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchGatewayMethods() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      idFindGateway == true
          ? isLoading.value = false
          : isGatewayMethodsLoading.value = false;
    }
  }

  // Next Step Function
  void nextStepWithValidation() {
    if (currentStep.value == 0) {
      if (!validateAmountStep()) {
        return;
      }
    }

    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
      reviewCalculate();
    } else {
      currentStep.value = 0;
    }
  }

  // Validate Amount Step
  bool validateAmountStep() {
    // Validate Wallet
    if (wallet.value.isEmpty) {
      ToastHelper().showErrorToast(localization.validationSelectWallet);
      return false;
    }

    // Validate Gateway
    if (gateway.value.isEmpty) {
      ToastHelper().showErrorToast(localization.validationSelectGateway);
      return false;
    }

    // Validate Amount
    if (amountController.text.isEmpty) {
      ToastHelper().showErrorToast(localization.validationEnterAmount);
      return false;
    }

    final amount = double.tryParse(amountController.text) ?? 0.0;
    if (amount <= 0) {
      ToastHelper().showErrorToast(
        localization.validationAmountGreaterThanZero,
      );
      return false;
    }

    // Validate Minimum Deposit
    if (minimumDeposit.value > 0 && amount < minimumDeposit.value) {
      ToastHelper().showErrorToast(
        localization.validationAmountMinimumDeposit(
          minimumDeposit.value.toStringAsFixed(2),
        ),
      );
      return false;
    }

    // Validate Maximum Deposit
    if (maximumDeposit.value > 0 && amount > maximumDeposit.value) {
      ToastHelper().showErrorToast(
        localization.validationAmountMaximumDeposit(
          maximumDeposit.value.toStringAsFixed(2),
        ),
      );
      return false;
    }

    // Validate Dynamic Fields
    for (var entry in dynamicFieldControllers.entries) {
      final fieldName = entry.key;
      final fieldData = entry.value;
      final validation = fieldData['validation'] as String?;
      final controller = fieldData['controller'] as TextEditingController?;

      if (validation == 'required') {
        if (fieldData['type'] == 'file') {
          if (selectedImages[fieldName] == null) {
            ToastHelper().showErrorToast(
              localization.validationUploadFile(fieldName),
            );
            return false;
          }
        } else if (controller == null || controller.text.trim().isEmpty) {
          ToastHelper().showErrorToast(
            localization.validationFillField(fieldName),
          );
          return false;
        }
      }
    }

    return true;
  }

  // Review Calculate Function
  void reviewCalculate() {
    baseAmount.value = double.tryParse(amountController.text) ?? 0.0;

    if (chargeType.value == 'percentage') {
      calculatedCharge.value = (baseAmount.value * charge.value / 100);
    } else if (chargeType.value == 'fixed') {
      calculatedCharge.value = charge.value;
    } else {
      calculatedCharge.value = 0.0;
    }

    totalAmount.value = baseAmount.value + calculatedCharge.value;
  }

  // Submit Add Money Auto Function
  Future<void> submitAddMoneyAuto() async {
    isPaymentLoading.value = true;

    try {
      final requestBody = {
        'payment_gateway': gatewayId.value,
        'amount': amountController.text,
        'user_wallet': isDefaultWallet.value == true
            ? "default"
            : walletId.value,
      };
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.postAddMoneyEndpoint,
        data: requestBody,
      );

      if (response.status == Status.completed) {
        final String redirectUrl = response.data!["data"]['redirect_url'];
        final paymentResult = await Get.to<Map<String, dynamic>>(
          () => WebViewScreen(paymentUrl: redirectUrl),
          fullscreenDialog: false,
        );
        if (paymentResult != null && paymentResult['success'] == true) {
          successPaymentData.value = paymentResult['data'];
          currentStep.value = 2;
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitAddMoneyAuto() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isPaymentLoading.value = false;
    }
  }

  // Submit Add Money Manual Function
  Future<void> submitAddMoneyManual() async {
    isPaymentLoading.value = true;

    try {
      final formData = dio.FormData();

      formData.fields.addAll([
        MapEntry('payment_gateway', gatewayId.value.toString()),
        MapEntry('amount', amountController.text),
        MapEntry(
          'user_wallet',
          isDefaultWallet.value == true ? "default" : walletId.value.toString(),
        ),
      ]);

      for (var entry in dynamicFieldControllers.entries) {
        final fieldName = entry.key;
        final fieldType = entry.value['type'] as String;

        if (fieldType == 'file') {
          final file = selectedImages[fieldName];
          if (file != null) {
            formData.files.add(
              MapEntry(
                'manual_data[$fieldName]',
                await dio.MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
          }
        } else {
          final controller =
              entry.value['controller'] as TextEditingController?;
          final fieldValue = controller?.text ?? '';
          formData.fields.add(MapEntry('manual_data[$fieldName]', fieldValue));
        }
      }

      final response = await dio.Dio().post(
        "${ApiPath.baseUrl}${ApiPath.postAddMoneyEndpoint}",
        data: formData,
        options: dio.Options(
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${tokenService.accessToken.value}',
          },
        ),
      );

      if (response.statusCode == 200) {
        pendingPaymentData.value = response.data['data'];
        currentStep.value = 3;
        ToastHelper().showSuccessToast(localization.addMoneySuccess);
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        ToastHelper().showErrorToast(e.response?.data['message']);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitAddMoneyManual() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isPaymentLoading.value = false;
    }
  }

  // Find Wallets
  Future<void> findWallet({required String walletIdQuery}) async {
    isLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.walletsEndpoint,
      );

      if (response.status == Status.completed) {
        final walletsModel = WalletsModel.fromJson(response.data!);
        walletsList.clear();
        walletsList.value = walletsModel.data!.wallets ?? [];
        final findWallet = walletsList.firstWhere(
          (wallet) => wallet.id.toString() == walletIdQuery,
        );
        wallet.value = findWallet.name.toString();
        walletId.value = findWallet.id.toString();
        currencyCode.value = findWallet.code.toString();
        isDefaultWallet.value = findWallet.isDefault ?? false;
        walletController.text = findWallet.name.toString();

        gatewayMethodsList.clear();
        await fetchGatewayMethods(idFindGateway: true);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ findWallet() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isLoading.value = false;
    }
  }

  // Pick Image Function
  Future<void> pickImage(String fieldName, ImageSource source) async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedImage != null) {
        selectedImages[fieldName] = File(pickedImage.path);
      }
    } finally {}
  }

  void clearFields() {
    successPaymentData.value = null;
    pendingPaymentData.value = null;

    // Wallet
    wallet.value = "";
    walletId.value = "";
    currencyCode.value = "";
    isDefaultWallet.value = false;
    walletController.clear();

    // Gateway
    gateway.value = "";
    gatewayId.value = "";
    charge.value = 0.0;
    chargeType.value = "";
    minimumDeposit.value = 0.0;
    maximumDeposit.value = 0.0;
    gatewayType.value = "";
    gatewayCurrency.value = "";
    gatewayInstructions.value = "";
    gatewayCurrencyType.value = "";
    currencyDecimals.value = 0;
    gatewayController.clear();
    gatewayMethodsList.clear();
    dynamicFieldControllers.clear();

    // Review Amounts
    baseAmount.value = 0.0;
    calculatedCharge.value = 0.0;
    totalAmount.value = 0.0;

    // Amount
    amountController.clear();
  }
}
