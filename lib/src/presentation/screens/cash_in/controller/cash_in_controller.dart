import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/common/model/converter_model.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/model/cash_in_config_model.dart';
import 'package:qunzo_agent/src/presentation/screens/cash_in/model/cash_in_wallet_model.dart';

class CashInController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isCashInLoading = false.obs;
  final RxBool isCashInConfigLoading = false.obs;
  final RxInt currentStep = 0.obs;
  final RxDouble charge = 0.0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final List<String> steps = ['Amount', 'Review', 'Success'];
  final Rx<CashInConfigModel> cashInConfig = CashInConfigModel().obs;
  final Rx<ConverterModel> converterModel = ConverterModel().obs;
  final Rxn<Map<String, dynamic>> successCashInData =
      Rxn<Map<String, dynamic>>();
  final localization = AppLocalizations.of(Get.context!);

  // Wallet
  final RxString wallet = "".obs;
  final RxString walletId = "".obs;
  final RxString walletName = "".obs;
  final RxString walletCurrency = "".obs;
  final RxDouble cashInMinLimit = 0.0.obs;
  final RxDouble cashInMaxLimit = 0.0.obs;
  final RxBool isCrypto = false.obs;
  final RxBool isDefaultWallet = false.obs;
  final walletController = TextEditingController();
  final RxList<Wallets> walletsList = <Wallets>[].obs;

  // Recipient UID
  final recipientUidController = TextEditingController();

  // Amount
  final amountController = TextEditingController();

  // Fetch Cash In Wallets
  Future<void> fetchCashInWallets() async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: "${ApiPath.walletsEndpoint}?cashin",
      );

      if (response.status == Status.completed) {
        final walletsModel = CashInWalletModel.fromJson(response.data!);
        walletsList.clear();
        walletsList.value = walletsModel.data!.wallets ?? [];
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchCashInWallets() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization!.allControllerLoadError);
    } finally {}
  }

  // Next Step Function
  Future<void> nextStepWithValidation() async {
    if (currentStep.value == 0) {
      if (!validateAmountStep()) {
        return;
      }
    }

    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
      await fetchCashInConfig();
    } else {
      currentStep.value = 0;
    }
  }

  // Fetch Cash In Config
  Future<void> fetchCashInConfig() async {
    isCashInConfigLoading.value = true;
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.cashInConfigEndpoint,
      );

      if (response.status == Status.completed) {
        cashInConfig.value = CashInConfigModel.fromJson(response.data!);
        _calculateCharge();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchCashInConfig() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization!.allControllerLoadError);
    } finally {}
  }

  // Charge Calculation
  Future<void> _calculateCharge() async {
    final amount = double.tryParse(amountController.text) ?? 0.0;
    final userChargeStr = cashInConfig.value.data!.settings!.charge ?? "0";
    final userChargeType =
        cashInConfig.value.data!.settings!.chargeType ?? "fixed";

    double calculatedCharge = 0.0;

    if (userChargeType == "percentage") {
      final percent = double.tryParse(userChargeStr) ?? 0.0;
      calculatedCharge = amount * percent / 100;
      charge.value = calculatedCharge;
      totalAmount.value = amount + calculatedCharge;
    } else {
      await getChargeConverter();
    }

    isCashInConfigLoading.value = false;
  }

  // Get Charge Converter
  Future<void> getChargeConverter() async {
    try {
      final response = await Get.find<NetworkService>().globalGet(
        endpoint: ApiPath.getConverterEndpoint(
          amount: cashInConfig.value.data!.settings!.charge!,
          currencyCode: walletCurrency.value,
        ),
      );
      if (response.status == Status.completed) {
        converterModel.value = ConverterModel.fromJson(response.data!);
        charge.value =
            double.tryParse(
              converterModel.value.data!.convertedAmount ?? "0",
            ) ??
            0.0;
        totalAmount.value =
            (double.tryParse(amountController.text)! + charge.value);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ getChargeConverter() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization!.allControllerLoadError);
    } finally {}
  }

  // Cash In Function
  Future<void> cashIn() async {
    isCashInLoading.value = true;

    final Map<String, dynamic> requestBody = {
      'account_number': recipientUidController.text.trim(),
      'amount': amountController.text.trim(),
      'wallet_id': isDefaultWallet.value == true
          ? "default"
          : walletId.value.toString(),
    };

    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.cashInEndpoint,
        data: requestBody,
      );

      if (response.status == Status.completed) {
        successCashInData.value = response.data!["data"];
        currentStep.value = 2;
        ToastHelper().showSuccessToast(response.data!["message"]);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ cashIn() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization!.allControllerLoadError);
    } finally {
      isCashInLoading.value = false;
    }
  }

  // Validate Amount Step
  bool validateAmountStep() {
    if (recipientUidController.text.isEmpty) {
      ToastHelper().showErrorToast(localization!.cashInValidationEnterUserUid);
      return false;
    }

    if (wallet.value.isEmpty) {
      ToastHelper().showErrorToast(localization!.cashInValidationSelectWallet);
      return false;
    }

    if (amountController.text.isEmpty) {
      ToastHelper().showErrorToast(localization!.cashInValidationEnterAmount);
      return false;
    }

    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: walletCurrency.value,
      siteCurrencyCode: Get.find<SettingsService>().getSetting(
        "site_currency",
      )!,
      siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: isCrypto.value,
    );

    final double enteredAmount =
        double.tryParse(amountController.text.trim()) ?? 0.0;
    final double min = cashInMinLimit.value;
    final double max = cashInMaxLimit.value;

    if (enteredAmount < min) {
      ToastHelper().showErrorToast(
        localization!.cashInValidationAmountMinimum(
          min.toStringAsFixed(calculateDecimals),
          walletCurrency.value,
        ),
      );
      return false;
    }

    if (enteredAmount > max) {
      ToastHelper().showErrorToast(
        localization!.cashInValidationAmountMaximum(
          max.toStringAsFixed(calculateDecimals),
          walletCurrency.value,
        ),
      );
      return false;
    }

    return true;
  }

  // Clear Fields
  void clearFields() {
    converterModel.value = ConverterModel();

    // Wallet
    wallet.value = "";
    walletId.value = "";
    walletName.value = "";
    walletCurrency.value = "";
    cashInMinLimit.value = 0.0;
    cashInMaxLimit.value = 0.0;
    isCrypto.value = false;
    isDefaultWallet.value = false;
    walletController.clear();

    // Agent AID
    recipientUidController.clear();

    // Amount
    amountController.clear();
    totalAmount.value = 0.0;

    // Stepper
    currentStep.value = 0;
  }
}
